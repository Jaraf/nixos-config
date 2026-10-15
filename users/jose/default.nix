{ pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";

  imports = [
    ../../common/users-apps.nix
  ];

  # Tus aplicaciones de usuario cotidianas
  home.packages = with pkgs; [
    birdtray
    chromium
    discord
    firefox
    thunderbird
    vlc
    vscodium
  ];

  # Forzar a Birdtray a correr bajo XWayland (xcb) para la bandeja del sistema en Wayland
  xdg.desktopEntries.birdtray = {
    name = "Birdtray";
    genericName = "Thunderbird New Mail Tray Notification";
    exec = "env QT_QPA_PLATFORM=xcb birdtray";
    icon = "birdtray";
    terminal = false;
    categories = [ "Network" "Email" "Qt" ];
    type = "Application";
    noDisplay = false;
  };

  # Habilitar gestor de sesiones de usuario
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings.user.name = "jaraf";
    settings.user.email = "joserugel@gmail.com";
  };

  home.stateVersion = "26.11";
}
