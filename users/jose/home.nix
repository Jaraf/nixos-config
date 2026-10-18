{ config, pkgs, ... }:

{
  home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
#    home-manager.users.jose = import ./users/jose/default.nix;
  }
}
