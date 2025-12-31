{ config, pkgs, lib, dotfilesPath, ... }:

let
  basePath = "${dotfilesPath}/base";
  link = file: config.lib.file.mkOutOfStoreSymlink "${basePath}/${file}";
in
{
  home.file = {
    ".xresources".source = link ".xresources";
    ".xmodmap".source = link ".xmodmap";
    ".xinitrc".source = link ".xinitrc";
    ".xbindkeysrc".source = link ".xbindkeysrc";
    ".xprofile".source = link ".xprofile";
    ".i3blocks.conf".source = link ".i3blocks.conf";
  };

  xdg.configFile = {
    "i3".source = link ".config/i3";
    "kitty".source = link ".config/kitty";
    "dunst".source = link ".config/dunst";
    "redshift.conf".source = link ".config/redshift.conf";
    "gtk-3.0".source = link ".config/gtk-3.0";
  };

  home.packages = [
  ];
}
