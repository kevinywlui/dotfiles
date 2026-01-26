{ pkgs, inputs, dotfilesPath, ... }:

{
  imports = [
    ../../modules/nixos/server.nix
    ../../modules/nixos/dev.nix
    ../../modules/nixos/stability.nix
    ../../modules/nixos/overlays.nix
    ./hardware.nix
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

  # Bootloader (Grub is safer for cloud VMs)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # CAUTION: Verify this matches your VM's disk
  # boot.loader.grub.efiSupport = true; # Uncomment if your VM uses EFI
  # boot.loader.efi.canTouchEfiVariables = true;

  home-manager.extraSpecialArgs = { inherit inputs dotfilesPath; };
  home-manager.users.klui = {
    imports = [
      ../../modules/home/core.nix
    ];
  };
}
