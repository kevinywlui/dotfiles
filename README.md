# Dotfiles & NixOS Configuration

My personal configuration files managed by [GNU Stow](https://www.gnu.org/software/stow/) and [NixOS](https://nixos.org/).

## Structure

*   **`base/`**: User-level configuration (Git, i3, Zsh, Neovim, etc.) managed via Stow.
*   **`nix/`**: System-level configuration using a modular Flake structure.
    *   **`hosts/`**: Host-specific configurations (e.g., `fw13` for Framework 13).
    *   **`modules/`**: Shared NixOS and Home Manager modules (`core`, `desktop`).

## Installation

### 1. System Setup (NixOS)
To apply the system configuration for a specific host:
```bash
cd nix
sudo nixos-rebuild switch --flake .#fw13
```

### 2. User Config (Dotfiles)
Once the system is set up, you can bootstrap your user environment with a single command:
```bash
setup-dotfiles
```
This script clones the repository (if not already present), symlinks files using `stow`, and installs `zplug`.

Alternatively, manual installation via the Makefile is still supported:
```bash
make install
```

## Development

This repository uses [pre-commit](https://pre-commit.com/) to ensure code quality.

*   **Checks:** `gitleaks` (secrets), `shellcheck` (scripts), `nixpkgs-fmt` (nix formatting), `stylua` (lua formatting).
*   **Run manually:**
    ```bash
    pre-commit run --all-files
    ```

## Key Commands

*   **Apply Nix Config:** `cd nix && sudo nixos-rebuild switch --flake .#fw13`
*   **Update Nix Inputs:** `cd nix && nix flake update`
*   **Bootstrap Dotfiles:** `setup-dotfiles`
*   **Install Dotfiles (Manual):** `make install`
*   **Update Dotfiles (adopt changes):** `make adopt`
