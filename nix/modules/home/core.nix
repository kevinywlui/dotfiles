{ config, pkgs, lib, dotfilesPath, ... }:

let
  basePath = "${dotfilesPath}/base";
  link = file: config.lib.file.mkOutOfStoreSymlink "${basePath}/${file}";
in
{
  home.username = "klui";
  home.homeDirectory = "/home/klui";

  home.file = {
    ".zshrc".source = link ".zshrc";
    ".zprofile".source = link ".zprofile";
    ".gitconfig".source = link ".gitconfig";
    ".p10k.zsh".source = link ".p10k.zsh";
    ".local/bin".source = link ".local/bin";
  };

  xdg.configFile = {
    "nvim".source = link ".config/nvim";
  };

  programs.home-manager.enable = true;

  home.packages = [
  ];

  home.stateVersion = "24.11";
}
