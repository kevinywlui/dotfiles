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

  # Add git commit hash and timestamp to bootloader entry (Moved from configuration.nix)
  system.nixos.label =
    let
      rev = inputs.self.rev or inputs.self.dirtyRev or "dirty";
      date = inputs.self.lastModifiedDate or "19700101000000";
      formattedDate = "${builtins.substring 0 4 date}_${builtins.substring 4 2 date}_${builtins.substring 6 2 date}-${builtins.substring 8 2 date}:${builtins.substring 10 2 date}";
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
