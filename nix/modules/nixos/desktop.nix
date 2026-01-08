{ pkgs, inputs, ... }:

{
  # Boot (Graphics)
  boot.initrd.availableKernelModules = [ "i915" ];

  # Networking (Desktop/Laptop usually needs NM)
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.targets.network.wantedBy = [ "multi-user.target" ];

  # Services - Desktop/Hardware
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  services.thermald.enable = true;
  services.psd.enable = true;
  services.upower.enable = true;
  services.logind.lidSwitch = "suspend";
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

  # Sound
  security.rtkit.enable = true;
  hardware.firmware = [ pkgs.linux-firmware ];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User Extras
  users.users.klui.extraGroups = [ "video" ];

  # Programs - Desktop
  programs.steam.enable = true;
  programs.light.enable = true;

  # Packages - Desktop
  environment.systemPackages =
    let
      browsers = with pkgs; [
        google-chrome
      ];

      wmTools = with pkgs; [
        arandr
        autorandr
        dunst
        i3blocks
        libnotify
        networkmanagerapplet
        rofi
        upower
        xbindkeys
        xorg.xinit
        xorg.xmodmap
        xss-lock
        xsecurelock
      ];

      audioTools = with pkgs; [
        pamixer
        pasystray
        pavucontrol
      ];

      guiUtils = with pkgs; [
        flameshot
      ];

      terminals = with pkgs; [
        kitty
      ];
    in
    browsers ++ wmTools ++ audioTools ++ guiUtils ++ terminals;

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      inter
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = [ "Inter" "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };

  # XServer / Window Manager
  services.xserver = {
    enable = true;
    displayManager.lightdm.greeters.gtk = {
      cursorTheme.size = 48;
      extraConfig = "xft-dpi = 192";
    };
    windowManager.i3.enable = true;
  };

  # Power Management (Laptop specific, fitting for this Desktop module for now)
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
    };
  };
}
