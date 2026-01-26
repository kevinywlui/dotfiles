{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixos-hardware, disko, home-manager, nixos-generators, ... }@inputs: {
    nixosConfigurations.fw13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        dotfilesPath = "/home/klui/Code/dotfiles";
      };
      modules = [
        nixos-hardware.nixosModules.framework-intel-core-ultra-series1
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        ./hosts/fw13/default.nix
      ];
    };

    nixosConfigurations.gcp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        dotfilesPath = "/home/klui/Code/dotfiles";
      };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/gcp/default.nix
      ];
    };

    packages.x86_64-linux.gce-image = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "gce";
      specialArgs = {
        inherit inputs;
        dotfilesPath = "/home/klui/Code/dotfiles";
      };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/gcp/default.nix
      ];
    };
  };
}
