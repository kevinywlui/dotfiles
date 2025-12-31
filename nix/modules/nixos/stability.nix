{ pkgs, config, lib, ... }:

{
  systemd.services.mark-stable = {
    description = "Mark current commit as stable after 10 minutes of uptime";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "klui";
      RemainAfterExit = true;
    };

    script = ''
      echo "Waiting 10 minutes before marking system as stable..."
      sleep 600

      # 1. Local Pinning
      echo "Pinning local system profile..."
      sudo ${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/stable --set /run/current-system

      # 2. Update 'Stable' Boot Entry
      echo "Updating stable boot entry..."
      INIT=$(readlink -f /run/current-system/init)
      ENTRY=$(grep -l "$INIT" /boot/loader/entries/nixos-generation-*.conf | head -n1)
      if [ -n "$ENTRY" ]; then
        sudo cp "$ENTRY" /boot/loader/entries/z-stable.conf
        sudo sed -i 's/^title .*/title NixOS (Stable)/' /boot/loader/entries/z-stable.conf
      fi

      # 3. Remote Branch Promotion
      echo "Promoting current commit to main branch..."
      cd /home/klui/Code/dotfiles

      # Ensure we have the latest info and push current HEAD to main
      CURRENT_HASH=$(${pkgs.git}/bin/git rev-parse HEAD)
      ${pkgs.git}/bin/git push origin $CURRENT_HASH:main --force

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
