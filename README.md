# Dotfiles & NixOS Configuration

My personal configuration files managed by [GNU Stow](https://www.gnu.org/software/stow/) and [NixOS](https://nixos.org/).

## Structure

*   **`base/`**: User-level configuration (Git, i3, Zsh, Neovim, etc.) managed via Stow.
*   **`nix/`**: System-level configuration (NixOS, Flakes, Home Manager).

## Installation

### 1. System Setup (NixOS)
To apply the system configuration (packages, services, hardware):
```bash
cd nix
sudo nixos-rebuild switch --flake .
```

### 2. User Config (Dotfiles)
To install the user configuration (symlink files to `~`):
```bash
make install
```
This handles installing `zplug` and stowing the `base` directory.

## Development

This repository uses [pre-commit](https://pre-commit.com/) to ensure code quality.

*   **Checks:** `gitleaks` (secrets), `shellcheck` (scripts), `nixpkgs-fmt` (nix formatting), `stylua` (lua formatting).
*   **Run manually:**
    ```bash
    pre-commit run --all-files
    ```

## Key Commands

*   **Apply Nix Config:** `cd nix && sudo nixos-rebuild switch --flake .`
*   **Update Nix Inputs:** `cd nix && nix flake update`
*   **Install Dotfiles:** `make install`
*   **Update Dotfiles (adopt changes):** `make adopt`
