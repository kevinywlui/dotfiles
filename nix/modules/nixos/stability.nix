{ pkgs, config, lib, dotfilesPath, inputs, ... }:

let
  rev = inputs.self.rev or "dirty";

  markStableScript = pkgs.writeShellApplication {
    name = "mark-stable";
    runtimeInputs = with pkgs; [ git coreutils gawk gnused nix systemd ];
    text = ''
      # 1. Health Check
      echo "Checking system health..."
      FAILED_UNITS=$(systemctl list-units --state=failed --no-legend | wc -l)
      if [ "$FAILED_UNITS" -gt 0 ]; then
        echo "System health check failed: $FAILED_UNITS units are in a failed state."
        systemctl list-units --state=failed
        exit 1
      fi

      # 2. Local Pinning
      echo "Pinning local system profile..."
      nix-env --profile /nix/var/nix/profiles/stable --set /run/current-system

      # 3. Update 'Stable' Boot Entry
      echo "Updating stable boot entry..."
      INIT=$(readlink -f /run/current-system/init)
      # Find the entry file used for the current boot
      ENTRY=$(grep -l "$INIT" /boot/loader/entries/nixos-generation-*.conf | head -n1)
      if [ -n "$ENTRY" ]; then
        cp "$ENTRY" /boot/loader/entries/z-stable.conf
        sed -i 's/^title .*/title NixOS (Stable)/' /boot/loader/entries/z-stable.conf
        sed -i '/^sort-key .*/d' /boot/loader/entries/z-stable.conf
      fi

      # 4. Remote Branch Promotion & Tagging
      BUILD_REV="${rev}"
      if [ "$BUILD_REV" = "dirty" ]; then
        echo "System was built from a dirty tree. Skipping remote promotion."
      else
        # Use the system label (e.g. fw13-20251230-1430-f7a7541) as the basis for the tag
        # We strip the hostname prefix to get a clean 'stable-YYYYMMDD-HHMM-rev' tag
        LABEL="${config.system.nixos.label}"
        TAG_NAME="stable-''${LABEL#*-}"
        echo "Promoting build revision $BUILD_REV to main and tagging as $TAG_NAME..."

        # Run as klui to use their SSH keys and git config.
        # Using -i to ensure login environment and -C to handle directory change.
        /run/wrappers/bin/sudo -i -u klui git -C "${dotfilesPath}" push origin "$BUILD_REV:main"
        /run/wrappers/bin/sudo -i -u klui git -C "${dotfilesPath}" tag "$TAG_NAME" "$BUILD_REV"
        /run/wrappers/bin/sudo -i -u klui git -C "${dotfilesPath}" push origin "$TAG_NAME"
        echo "System successfully marked as stable."
      fi
    '';
  };
in
{
  environment.systemPackages = [ markStableScript ];

  systemd.timers.mark-stable = {
    description = "Timer for mark-stable service";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "10m";
      Unit = "mark-stable.service";
    };
  };

  systemd.services.mark-stable = {
    description = "Mark current commit as stable";
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${markStableScript}/bin/mark-stable";
    };
  };
}
