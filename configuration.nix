{ pkgs, ... }: 

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-test-vm";
  networking.wireless.iwd.enable = true;
  
  # Enable a basic environment
  services.getty.autologinUser = "nixos";
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ and brightness control
    initialPassword = "nixos";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.htop.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  environment.systemPackages = with pkgs; [
    vim
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
    wget
    unzip
    stow
    gnumake
    zplug
    pamixer
    xbindkeys
    xorg.xmodmap
    xorg.xinit
    acpi
  ];

  programs.light.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  system.stateVersion = "24.11"; 
}
