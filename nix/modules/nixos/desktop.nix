{ pkgs, inputs, ... }:

{
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

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  # Services - Desktop
  services.psd.enable = true;

  # Programs - Desktop
  programs.steam.enable = true;

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
        monospace = [ "MesloLGS Nerd Font" "FiraCode Nerd Font" ];
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
}
