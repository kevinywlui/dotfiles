{ pkgs, inputs, dotfilesPath, ... }:

let
  setupDotfiles = pkgs.writeShellApplication {
    name = "setup-dotfiles";
    runtimeInputs = with pkgs; [ git gnumake coreutils ];
    text = ''
      mkdir -p ~/Code

      if [ "''${1:-}" == "--force" ]; then
        echo "Force flag detected. Removing existing dotfiles..."
        rm -rf "${dotfilesPath}"
      fi

      if [ -d "${dotfilesPath}" ]; then
        echo "Dotfiles already exist at ${dotfilesPath}. Use --force to overwrite."
      else
        echo "Cloning dotfiles..."
        git clone https://github.com/kevinywlui/dotfiles.git "${dotfilesPath}"

        echo "Installing dotfiles (stow + zplug)..."
        cd "${dotfilesPath}"
        make install
      fi
    '';
  };
in
{
  # Nix & Flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nixpkgs.config.allowUnfree = true;

  # Home Manager Global Settings
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${dotfilesPath}/nix";
  };

  # Localization
  time.timeZone = "America/Los_Angeles";

  # Networking
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

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

  environment.systemPackages =
    let
      systemUtils = with pkgs; [
        acpi
        btrfs-progs
        gnumake
        grobi
        nixpkgs-fmt
        pre-commit
        shfmt
        stow
        tailscale
        udiskie
        unzip
        wget
      ];

      devTools = with pkgs; [
        clang
        gitleaks
        nodejs_latest
        shellcheck
        stylua
        tree-sitter
      ];

      cliTools = with pkgs; [
        fd
        fzf
        jj
        ripgrep
        unstable.gemini-cli-bin
        vim
        zoxide
        setupDotfiles
      ];
    in
    systemUtils ++ devTools ++ cliTools;

  environment.sessionVariables = {
    FLAKE = "${dotfilesPath}/nix";
  };

  # Services - Core
  services.tailscale.enable = true;
  services.resolved.enable = true;
  services.earlyoom.enable = true;

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  # Swap (zram)
  zramSwap.enable = true;


  system.stateVersion = "24.11";
}
