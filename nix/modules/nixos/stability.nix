{ pkgs, config, lib, dotfilesPath, ... }:

{
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
    };

    script = ''
      # 1. Local Pinning
      echo "Pinning local system profile..."
      ${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/stable --set /run/current-system

      # 2. Update 'Stable' Boot Entry
      echo "Updating stable boot entry..."
      INIT=$(readlink -f /run/current-system/init)
      ENTRY=$(grep -l "$INIT" /boot/loader/entries/nixos-generation-*.conf | head -n1)
      if [ -n "$ENTRY" ]; then
        cp "$ENTRY" /boot/loader/entries/z-stable.conf
        sed -i 's/^title .*/title NixOS (Stable)/' /boot/loader/entries/z-stable.conf
      fi

      # 3. Remote Branch Promotion
      echo "Promoting current commit to main branch..."
      # Run as klui to use their SSH keys and git config.
      # Using -i to ensure login environment and -C to handle directory change.
      /run/wrappers/bin/sudo -i -u klui ${pkgs.git}/bin/git -C ${dotfilesPath} push origin HEAD:main --force

      echo "System successfully marked as stable."
    '';
  };

  # Allow klui to pin the system profile and update boot entries without a password
  security.sudo.extraRules = [
    {
      users = [ "klui" ];
      commands = [
        {
          command = "${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/stable --set /run/current-system";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/cp /boot/loader/entries/nixos-generation-*.conf /boot/loader/entries/z-stable.conf";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/sed -i s/^title .*/title NixOS (Stable)/ /boot/loader/entries/z-stable.conf";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
