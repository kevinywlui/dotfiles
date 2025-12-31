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
    zplug

    # Development
    clang
    fd
    gitleaks
    jj
    nodejs_latest
    ripgrep
    shellcheck
    stylua
    tree-sitter
    unstable.gemini-cli-bin
    vim
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
