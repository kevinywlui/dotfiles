{ pkgs, ... }: 

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "fw13";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  
  services.fwupd.enable = true;
  services.fprintd.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable a basic environment
  services.getty.autologinUser = "klui";
  users.users.klui = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ and brightness control
    initialPassword = "klui";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.steam.enable = true;
  programs.htop.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  environment.systemPackages = with pkgs; [
    acpi
    arandr
    autorandr
    btrfs-progs
    clang
    dunst
    fd
    fzf
    gnumake
    google-chrome
    grobi
    i3blocks
    iwgtk
    jj
    kitty
    nodejs_latest
    pamixer
    pavucontrol
    playerctl
    pulseaudio
    ripgrep
    rofi
    stow
    telegram-desktop
    unstable.gemini-cli-bin
    unzip
    vim
    wget
    xbindkeys
    xorg.xinit
    xorg.xmodmap
    zplug
  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  programs.light.enable = true;

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.i3.enable = true;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  system.stateVersion = "24.11"; 
}
