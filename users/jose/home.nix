{ config, pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";
  home.stateVersion = "26.11";

#  home.packages = with pkgs; [ vlc ];

  programs.home-manager.enable = true;
  
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  xdg.configFile."mc/ini".source = ../../common/.config/mc/ini;
  xdg.configFile."mc/panels.ini".source = ../../common/.config/mc/panels.ini;
}
