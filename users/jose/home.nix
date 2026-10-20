{ config, pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";
  home.stateVersion = "26.11";

#  home.packages = with pkgs; [ vlc ];

  programs.home-manager.enable = true;
  
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    # Añade esta línea para que ZapZap encuentre el proceso de WebEngine
    QTWEBENGINEPROCESS_PATH = "${pkgs.qt6.qtwebengine}/lib/qt-6/libexec/QtWebEngineProcess";
  };

  xdg.configFile."mc/ini".source = ../../common/.config/mc/ini;
  xdg.configFile."mc/panels.ini".source = ../../common/.config/mc/panels.ini;
}
