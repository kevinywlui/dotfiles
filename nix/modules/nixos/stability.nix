{ pkgs, config, lib, ... }:

{
  systemd.services.mark-golden = {
    description = "Mark current commit as golden after 10 minutes of uptime";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "klui";
      RemainAfterExit = true;
    };

    script = ''
      echo "Waiting 10 minutes before marking system as golden..."
      sleep 600

      # 1. Local Pinning
      # We use sudo to create a system-level profile pin.
      # Note: We'll need to add a sudo rule for this to be passwordless.
      echo "Pinning local system profile..."
      sudo ${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/golden --set /run/current-system

      # 2. Remote Branch Promotion
      echo "Promoting current commit to main branch..."
      cd /home/klui/Code/dotfiles

      # Ensure we have the latest info and push current HEAD to main
      CURRENT_HASH=$(${pkgs.git}/bin/git rev-parse HEAD)
      ${pkgs.git}/bin/git push origin $CURRENT_HASH:main --force

      echo "System successfully marked as golden."
    '';
  };

  # Allow klui to pin the system profile without a password
  security.sudo.extraRules = [
    {
      users = [ "klui" ];
      commands = [
        {
          command = "/nix/var/nix/profiles/default/bin/nix-env --profile /nix/var/nix/profiles/golden --set /run/current-system";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/golden --set /run/current-system";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
