# Dotfiles

My configuration files managed by [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

*   **base**: Contains all configurations (Git, X11, Shell, i3, etc.).
*   **nix**: Contains the NixOS system configuration.

## Installation

1.  **Install Dependencies**:
    *   **Stow**:
        ```bash
        # Arch Linux
        sudo pacman -S stow fzf

        # Debian/Ubuntu
        sudo apt install stow fzf
        ```

2.  **Clone the repository**:
    ```bash
    git clone https://github.com/kevinywlui/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

3.  **Install**:
    ```bash
    make install
    ```

## Notes

*   **Neovim**: The configuration is located in `base/.config/nvim`.
*   **Zsh**: Uses `zplug` (automatically installed to `~/.zplug` by the Makefile).
*   **Scripts**: User scripts are installed to `~/.local/bin`.