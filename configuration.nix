{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-test-vm";
  
  # Enable a basic environment
  services.getty.autologinUser = "nixos";
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’
    initialPassword = "nixos";
  };

  system.stateVersion = "unstable"; 
}
