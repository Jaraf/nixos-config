{ pkgs, ... }:

{

  security.sudo.extraRules = [
    {
      users = [ "jose" ];
      commands = [
        {
#          command = "${pkgs.mc}/bin/mc";
          command = "/run/current-system/sw/bin/mc";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  home.username = "jose";
  home.homeDirectory = "/home/jose";

  imports = [
    ../../common/users-apps.nix
  ];

  # Tus aplicaciones de usuario cotidianas
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

  # Habilitar gestor de sesiones de usuario
  programs.home-manager.enable = true;

  targets.genericLinux.enable = false;

  # Forzar a Qt a utilizar la integración de forma estable en Wayland/X11
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  # Enlazar automáticamente los archivos .desktop para que aparezcan en KDE Plasma 6
  home.activation.linkDesktopFiles = {
    after = [ "writeBoundary" ];
    before = [ ];
    data = ''
      mkdir -p $HOME/.local/share/applications
      ln -sfn $HOME/.nix-profile/share/applications/* $HOME/.local/share/applications/
    '';
  };

  programs.git = {
    enable = true;
    settings.user.name = "jaraf";
    settings.user.email = "joserugel@gmail.com";
  };

  home.stateVersion = "26.11";
}
