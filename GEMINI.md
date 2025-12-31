# AI Agent Context: Architecture & Intent

This document tracks specialized workflows and architectural choices to ensure future agents maintain the repository's integrity and cross-platform compatibility.

## 1. Verified Development Loop
This project uses **`nh os build .`** as the primary verification tool during development and refactoring.

- **Purpose:** To prevent silent regressions, such as the accidental removal of packages or services.
- **Workflow:** `nh` automatically runs `nvd diff` between the currently active system and the newly built derivation. This provides a human-readable summary of every package addition, removal, or version change.
- **Guideline:** Agents should run this command before committing changes. Any unexpected package removals (`- [package]`) in the output must be investigated and resolved.

## 2. Cross-Platform Configuration Strategy
Home Manager modules in this repository (e.g., `nix/modules/home/core.nix`) prioritize **`mkOutOfStoreSymlink`** for most application settings.

- **Purpose:** To maintain a "Hybrid" setup that works seamlessly on both NixOS and non-Nix systems (like macOS or other Linux distros).
- **Functionality:**
    - **NixOS:** Home Manager creates symlinks pointing directly to the files in the `base/` directory of this repository.
    - **Non-Nix:** The user uses **GNU Stow** to create identical symlinks from the same `base/` directory.
- **Benefits:**
    - **Shared Logic:** The exact same shell aliases, editor settings, and scripts are shared across all machines.
    - **Instant Updates:** Changes to files in `base/` (like `.zshrc`) take effect immediately in new sessions without requiring a system rebuild.
- **Guideline:** Do not move these configurations into declarative Nix attributes (e.g., `programs.zsh.shellAliases`) unless they are intended to be NixOS-exclusive.
