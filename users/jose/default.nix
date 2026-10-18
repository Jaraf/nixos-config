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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jose = import ./home.nix;
  };
}
