{ config, pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";
  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    birdtray #Thunderbird command line: /usr/bin/env GDK_BACKEND=x11 thunderbird
    chromium
    discord
    element-desktop
    firefox
    heroic
    obs-studio
    pcsx2
    qbittorrent
    rpcs3
    telegram-desktop
    thunderbird
    vlc
    vscodium
    zapzap
  ];

  programs.home-manager.enable = true;
  
  # Tus variables y configuraciones de sesión anteriores...
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  xdg.configFile."mc/ini".source = ../../common/.config/mc/ini;
  xdg.configFile."mc/panels.ini".source = ../../common/.config/mc/panels.ini;
}
