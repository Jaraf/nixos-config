{ config, pkgs, ... }:

{
  imports = [
    ../../common/mangohud.nix
    ../../common/steam.nix
  ];

  environment.systemPackages = with pkgs; [
    birdtray #Thunderbird command line: /usr/bin/env GDK_BACKEND=x11 thunderbird
    discord
    element-desktop
    heroic
    jellyfin-desktop
    obs-studio
    pcsx2
    qbittorrent
    rpcs3
    telegram-desktop
    thunderbird
    vscodium
    zapzap
  ];

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
