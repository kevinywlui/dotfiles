{ pkgs, inputs, dotfilesPath, ... }:

{
  imports = [
    ../../modules/nixos/core.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/stability.nix
    ../../modules/nixos/overlays.nix
    ./hardware.nix
    ./disko.nix
  ];

  networking.hostName = "fw13";

  # Add git commit hash and timestamp to bootloader entry
  # This label is also used by the stability mechanism for git tagging.
  system.nixos.label =
    let
      rev = inputs.self.rev or inputs.self.dirtyRev or "dirty";
      date = inputs.self.lastModifiedDate or "19700101000000";
      formattedDate = "${builtins.substring 0 8 date}-${builtins.substring 8 4 date}";
    in
    "fw13-${formattedDate}-${builtins.substring 0 7 rev}";

  # Bootloader (Host specific)
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  home-manager.extraSpecialArgs = { inherit inputs dotfilesPath; };
  home-manager.users.klui = {
    imports = [
      ../../modules/home/core.nix
      ../../modules/home/desktop.nix
    ];
  };
}
