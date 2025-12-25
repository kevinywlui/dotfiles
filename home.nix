{ config, pkgs, lib, ... }:

let
  dotfilesPath = "${config.home.homeDirectory}/Code/dotfiles/base";
  link = file: config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${file}";
in
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.file = {
    ".zshrc".source = link ".zshrc";
    ".zprofile".source = link ".zprofile";
    ".gitconfig".source = link ".gitconfig";
    ".xmodmap".source = link ".xmodmap";
    ".xinitrc".source = link ".xinitrc";
    ".xbindkeysrc".source = link ".xbindkeysrc";
    ".i3blocks.conf".source = link ".i3blocks.conf";
    ".local/bin".source = link ".local/bin";
  };

  xdg.configFile = {
    "i3".source = link ".config/i3";
    "nvim".source = link ".config/nvim";
    "kitty".source = link ".config/kitty";
    "dunst".source = link ".config/dunst";
    "redshift.conf".source = link ".config/redshift.conf";
  };

  programs.home-manager.enable = true;

  home.packages = [
    (pkgs.writeShellScriptBin "setup-dotfiles" ''
      mkdir -p ~/Code
      if [ -d ~/Code/dotfiles ]; then
        echo "Dotfiles already exist at ~/Code/dotfiles"
      else
        echo "Cloning dotfiles..."
        ${pkgs.git}/bin/git clone git@github.com:kevinywlui/dotfiles.git ~/Code/dotfiles
      fi
    '')
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.stateVersion = "24.11"; 
}
