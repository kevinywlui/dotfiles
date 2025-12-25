{ pkgs, inputs, ... }: 
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-test-vm";
  
  # Enable a basic environment
  services.getty.autologinUser = "nixos";
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’
    initialPassword = "nixos";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    unstable.neovim
    vim
    git
    jj
    btrfs-progs
    kitty
    rofi
    google-chrome
    dunst
    i3blocks
    ripgrep
    fd
    fzf
    htop
    wget
    unzip
    stow
    gnumake
    zplug
  ];

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  system.stateVersion = "24.11"; 
}
