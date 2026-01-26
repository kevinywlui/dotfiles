{ pkgs, ... }:

{
  imports = [
    ./core.nix
  ];

  # User - SSH Keys
  users.users.klui.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHV+hk6kAxr4MtnjUdIeW5aBTwcYnOYKAt/psLyHb3q6 klui@fw13"
  ];

  # Security - SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password"; # Required for nixos-anywhere
    };
  };

  # Firewall
  networking.firewall.allowedTCPPorts = [ 22 ];
}
