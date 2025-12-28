{ config, pkgs, lib, ... }:

let
  dotfilesPath = "${config.home.homeDirectory}/Code/dotfiles/base";
  link = file: config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${file}";
in
{
  home.username = "klui";
  home.homeDirectory = "/home/klui";

  home.file = {
    ".zshrc".source = link ".zshrc";
    ".zprofile".source = link ".zprofile";
    ".gitconfig".source = link ".gitconfig";
    ".xresources".source = link ".xresources";
    ".xmodmap".source = link ".xmodmap";
    ".xinitrc".source = link ".xinitrc";
    ".xbindkeysrc".source = link ".xbindkeysrc";
    ".xprofile".source = link ".xprofile";
    ".i3blocks.conf".source = link ".i3blocks.conf";
    ".p10k.zsh".source = link ".p10k.zsh";
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
    pkgs.xss-lock
    pkgs.xsecurelock
    (pkgs.writeShellScriptBin "setup-dotfiles" ''
      mkdir -p ~/Code

      if [ "$1" == "--force" ]; then
        echo "Force flag detected. Removing existing dotfiles..."
        rm -rf ~/Code/dotfiles
      fi

      if [ -d ~/Code/dotfiles ]; then
        echo "Dotfiles already exist at ~/Code/dotfiles. Use --force to overwrite."
      else
        echo "Cloning dotfiles..."
        ${pkgs.git}/bin/git clone https://github.com/kevinywlui/dotfiles.git ~/Code/dotfiles
      fi
    '')
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.stateVersion = "24.11"; 
}
