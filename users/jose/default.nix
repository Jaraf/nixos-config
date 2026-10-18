{ config, pkgs, ... }:

{
  security.sudo.extraRules = [
    {
      users = [ "jose" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/mc";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  imports = [
    ../../common/env-apps.nix
    ../../common/mangohud.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jose = import ./home.nix;
  };
}
