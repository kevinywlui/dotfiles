{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixos-hardware, disko, home-manager, ... }@inputs: {
    nixosConfigurations.fw13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        nixos-hardware.nixosModules.framework-intel-core-ultra-series1
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        ./disko.nix
        ./hardware-configuration.nix
        ./configuration.nix
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = final.system;
                config.allowUnfree = true;
              };
            })
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.klui = import ./home.nix;
        }
      ];
    };
  };
}
