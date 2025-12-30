# NixOS on Framework 13 (Intel Core Ultra)

This repository contains the NixOS configuration for a Framework 13 Laptop (Intel Core Ultra Series 1) using Flakes, Home Manager, and Disko.

## Features
- **Encrypted Btrfs**: LUKS-on-disk with subvolumes for `/`, `/home`, and `/nix`.
- **Framework Support**: Optimized via `nixos-hardware` (fingerprint reader, power tuning, etc.).
- **Modern Shell**: Zsh with `fzf` integration and `p10k` theme.
- **Applications**: Unstable Neovim, Kitty, i3wm, and system utilities.

## Installation Instructions

### 1. Boot the Installer
Choose one of the two methods below to get into the NixOS Live environment.

#### Method A: Using a USB Drive (Standard)
Boot the laptop using a recent NixOS Graphical Live USB. Connect to the internet.

#### Method B: No USB Drive (Kexec from existing Linux)
If you already have a Linux distribution installed, you can boot the NixOS installer directly into RAM:

```bash
# Download and extract the kexec installer
curl -L https://github.com/nix-community/nixos-images/releases/download/nixos-24.11/nixos-kexec-installer-x86_64-linux.tar.gz | tar -xzf -

# Switch to the NixOS installer (will kill your current session)
sudo ./netboot.sh
```

### 2. Partition and Format (Disko)
**WARNING: This will wipe `/dev/nvme0n1`.**
Clone this repository and run the Disko script to set up the encrypted partitions:

```bash
sudo nix --extra-experimental-features "nix-command flakes" \
  run github:nix-community/disko -- --mode zap_create_mount ./disko.nix
```
*Note: You will be prompted to set a LUKS passphrase.*

### 3. Generate Hardware Configuration
Generate the hardware-specific file to capture your laptop's unique device IDs:

```bash
nixos-generate-config --no-fstab --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
```

### 4. Perform Installation
Install the system using the `fw13` flake configuration:

```bash
sudo nixos-install --flake .#fw13
```

### 5. Finalize
Reboot into your new system. Once logged in, bootstrap your dotfiles:

```bash
setup-dotfiles
```

## Testing in a VM
You can test the configuration (packages, shell, home-manager) in a virtual machine without affecting your host system:

```bash
nix run --extra-experimental-features "nix-command flakes" .
```

## Maintenance

### Rebuilding the System
To apply changes to your configuration:
```bash
sudo nixos-rebuild switch --flake .
```

### Updating Packages
To update the flake inputs (like Neovim unstable):
```bash
nix flake update
sudo nixos-rebuild switch --flake .
```
