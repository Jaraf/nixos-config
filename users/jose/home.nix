{ config, pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";
  home.stateVersion = "26.11";

#  home.packages = with pkgs; [ vlc ];

  programs.home-manager.enable = true;
  
  # Tus variables y configuraciones de sesión anteriores...
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  xdg.configFile."mc/ini".source = ../../common/.config/mc/ini;
  xdg.configFile."mc/panels.ini".source = ../../common/.config/mc/panels.ini;
}
