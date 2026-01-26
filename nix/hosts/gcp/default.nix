{ pkgs, inputs, dotfilesPath, ... }:

{
  imports = [
    ../../modules/nixos/server.nix
    ../../modules/nixos/dev.nix
    ../../modules/nixos/stability.nix
    ../../modules/nixos/overlays.nix
    ./hardware.nix
    ./disko.nix
  ];

  networking.hostName = "gcp";

  # Add git commit hash and timestamp to bootloader entry
  system.nixos.label =
    let
      rev = inputs.self.rev or inputs.self.dirtyRev or "dirty";
      date = inputs.self.lastModifiedDate or "19700101000000";
      formattedDate = "${builtins.substring 0 8 date}-${builtins.substring 8 4 date}";
    in
    "gcp-${formattedDate}-${builtins.substring 0 7 rev}";

  # Bootloader
  boot.loader.grub.enable = true;
  # device is not strictly required if installing to the same disk as MBR,
  # but good to be explicit or let install-grub handle it.
  # For safety in this setup, we'll assume /dev/sda or let the installer handle it.

  home-manager.extraSpecialArgs = { inherit inputs dotfilesPath; };
  home-manager.users.klui = {
    imports = [
      ../../modules/home/core.nix
    ];
  };
}
