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

  outputs = { self, nixpkgs, disko, home-manager, nixos-hardware, ... }@inputs: {
    nixosConfigurations.fw13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        nixos-hardware.nixosModules.framework-intel-core-ultra-series1
        disko.nixosModules.disko
        ./disko.nix
        ./hardware-configuration.nix
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = final.system;
                config.allowUnfree = true;
              };
            })
          ];
        }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.klui = import ./home.nix;
        }
      ];
    };

    nixosConfigurations.my-test-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = final.system;
                config.allowUnfree = true;
              };
            })
          ];
        }
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.klui = import ./home.nix;
        }
        ({ pkgs, ... }: {
          # Minimal configuration for VM
          boot.loader.systemd-boot.enable = pkgs.lib.mkForce false; # QEMU handles booting usually
          fileSystems."/" = { device = "/dev/vda1"; fsType = "ext4"; };
        })
      ];
    };

    apps.x86_64-linux.default = {
      type = "app";
      program = "${self.nixosConfigurations.my-test-vm.config.system.build.vm}/bin/run-fw13-vm";
    };
  };
}
