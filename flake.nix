{
  description = "NixOS Configuración Modular Global";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs: {
    
    # 1. Opción Global: sudo nixos-rebuild switch --flake .#jose-nb
    nixosConfigurations = {
      "jose-nb" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hosts/jose-nb/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jose = import ./users/jose/default.nix;
          }
        ];
      };
    };

    # 2. Opción Standalone (Usuario sin root): home-manager switch --flake .#jose@jose-nb
    homeConfigurations = {
      "jose@jose-nb" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./users/jose/default.nix ];
      };
    };
    
    # 3. Proxmox VM - BIOS
    nixosConfigurations = {
      "vm-bios" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hosts/vm-bios/default.nix
        ];
      };
    };

  };
}

