{ config, pkgs, ... }:

let
  dotfilesPath = "${config.home.homeDirectory}/Code/dotfiles/base";
in
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.file = {
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.zshrc";
    ".zprofile".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.zprofile";
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.gitconfig";
    ".xmodmap".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.xmodmap";
    ".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.xinitrc";
    ".xbindkeysrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.xbindkeysrc";
    ".i3blocks.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.i3blocks.conf";
  };

  xdg.configFile = {
    "i3".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/i3";
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/nvim";
    "kitty".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/kitty";
    "dunst".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/dunst";
    "redshift.conf".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/redshift.conf";
  };

  home.file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.local/bin";

  programs.home-manager.enable = true;

  home.stateVersion = "24.11"; 
}
