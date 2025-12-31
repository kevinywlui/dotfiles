# Dotfiles & NixOS Configuration

My personal configuration files managed by [GNU Stow](https://www.gnu.org/software/stow/) and [NixOS](https://nixos.org/).

## Structure

*   **`base/`**: User-level configuration (Git, i3, Zsh, Neovim, etc.) managed via Stow.
*   **`nix/`**: System-level configuration using a modular Flake structure.
    *   **`hosts/`**: Host-specific configurations (e.g., `fw13` for Framework 13).
    *   **`modules/`**: Shared NixOS and Home Manager modules (`core`, `desktop`, `stability`).

## Stability Workflow

This repository uses a "Soak Test" pattern to ensure system stability:

1.  **`dev` Branch**: All active development happens here. Push your changes and `nixos-rebuild` from this branch.
2.  **`main` Branch**: This is the **Stable** branch. It is only updated automatically.
3.  **Automatic Promotion**: A systemd service (`mark-stable`) monitors the system. If the system stays up for 10 minutes, the service:
    *   Pins the current system locally at `/nix/var/nix/profiles/stable`.
    *   Force-pushes the current commit to the `main` branch.

To recover or deploy a known-good version, use the `main` branch.

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
