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
    "fish/config.fish".source = link ".config/fish/config.fish";
    "fish/fish_variables".source = link ".config/fish/fish_variables";
  };

  programs.home-manager.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = false; # Handled in config.fish
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = false; # Handled in config.fish
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false; # Handled in config.fish
  };

  home.packages = [
    pkgs.fish
  ];

  home.stateVersion = "24.11";
}
