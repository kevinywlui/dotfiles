{ pkgs, ... }:

{
  imports = [
    ./core.nix
  ];

  # Security - SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Firewall
  networking.firewall.allowedTCPPorts = [ 22 ];
}
