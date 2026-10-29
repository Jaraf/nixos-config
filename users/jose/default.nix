{ config, pkgs, lib, ... }:

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
    jellyfin-mpv-shim
    obs-studio
    pcsx2
    qbittorrent
    rpcs3
    sunshine
    telegram-desktop
    thunderbird
    vscodium
    zapzap
  ];

  # environment.variables = {
  #  QTWEBENGINEPROCESS_PATH = "${lib.getBin pkgs.qt6.qtbase}/libexec/QtWebEngineProcess";
  # };

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
