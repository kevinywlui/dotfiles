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

  outputs = { self, nixpkgs, disko, home-manager, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      
      unstableOverlay = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };

      commonModules = [
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [ unstableOverlay ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.klui = import ./home.nix;
        }
      ];
    in
    {
    nixosConfigurations.fw13 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        nixos-hardware.nixosModules.framework-intel-core-ultra-series1
        disko.nixosModules.disko
        ./disko.nix
        ./hardware-configuration.nix
        ./configuration.nix
      ] ++ commonModules;
    };

    nixosConfigurations.my-test-vm = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
          # Minimal configuration for VM
          boot.loader.systemd-boot.enable = true;
          boot.loader.grub.enable = false;
          fileSystems."/" = { device = "/dev/vda1"; fsType = "ext4"; };
        })
      ] ++ commonModules;
    };

    apps.x86_64-linux.default = {
      type = "app";
      program = "${self.nixosConfigurations.my-test-vm.config.system.build.vm}/bin/run-fw13-vm";
    };
  };
}
