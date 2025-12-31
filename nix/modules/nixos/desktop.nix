{ pkgs, inputs, ... }:

{
  # Networking (Desktop/Laptop usually needs NM)
  networking.networkmanager.enable = true;

  # Services - Desktop/Hardware
  services.fwupd.enable = true;
  services.fprintd.enable = true;
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
        networkmanagerapplet
        rofi
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
  fonts.packages = with pkgs; [
    nerdfonts
  ];

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
}
