{ pkgs, inputs, ... }: 

{
  boot.initrd.availableKernelModules = [ "i915" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Add git commit hash and timestamp to bootloader entry
  system.nixos.label = let
    rev = inputs.self.rev or inputs.self.dirtyRev or "dirty";
    date = inputs.self.lastModifiedDate or "19700101000000";
    formattedDate = "${builtins.substring 0 4 date}_${builtins.substring 4 2 date}_${builtins.substring 6 2 date}-${builtins.substring 8 2 date}:${builtins.substring 10 2 date}";
  in "fw13-${formattedDate}-${builtins.substring 0 7 rev}";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "fw13";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  time.timeZone = "America/Los_Angeles";
  
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  services.logind.lidSwitch = "suspend";

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  hardware.firmware = [ pkgs.linux-firmware ];
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
    extraGroups = [ "syncthing" "wheel" "video" ]; # Enable ‘sudo’ and brightness control
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
    calibre
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
    tree-sitter
    unstable.gemini-cli-bin
    unzip
    vim
    wget
    xbindkeys
    xorg.xinit
    xorg.xmodmap
    zplug
    zoxide
  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  programs.light.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
  };

  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
};

  system.stateVersion = "24.11"; 
}
