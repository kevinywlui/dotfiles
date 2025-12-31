{ pkgs, inputs, ... }:

{
  # Nix & Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = final.system;
        config.allowUnfree = true;
      };
    })
  ];

  # Home Manager Global Settings
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/klui/Code/dotfiles/nix";
  };

  # Localization
  time.timeZone = "America/Los_Angeles";

  # User
  users.users.klui = {
    isNormalUser = true;
    extraGroups = [ "wheel" "syncthing" ];
    initialPassword = "klui";
    shell = pkgs.zsh;
  };

  # Programs - Core CLI
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.htop.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  environment.systemPackages = with pkgs; [
    # System / Utils
    acpi
    btrfs-progs
    gnumake
    grobi
    nixpkgs-fmt
    pre-commit
    shfmt
    stow
    udiskie
    unzip
    wget

    # Development
    clang
    fd
    fzf
    gitleaks
    jj
    nodejs_latest
    ripgrep
    shellcheck
    stylua
    tree-sitter
    unstable.gemini-cli-bin
    vim
    zoxide
    (writeShellScriptBin "setup-dotfiles" ''
      mkdir -p ~/Code

      if [ "$1" == "--force" ]; then
        echo "Force flag detected. Removing existing dotfiles..."
        rm -rf ~/Code/dotfiles
      fi

      if [ -d ~/Code/dotfiles ]; then
        echo "Dotfiles already exist at ~/Code/dotfiles. Use --force to overwrite."
      else
        echo "Cloning dotfiles..."
        ${git}/bin/git clone https://github.com/kevinywlui/dotfiles.git ~/Code/dotfiles

        echo "Installing dotfiles (stow + zplug)..."
        cd ~/Code/dotfiles
        ${gnumake}/bin/make install
      fi
    '')
  ];

  environment.sessionVariables = {
    FLAKE = "/home/klui/Code/dotfiles/nix";
  };

  # Services - Core
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };


  system.stateVersion = "24.11";
}
