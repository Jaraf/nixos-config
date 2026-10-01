{ pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";

  # Tus aplicaciones de usuario cotidianas
  home.packages = with pkgs; [
    firefox
    vscode
    htop
    fastfetch
    discord
    vlc
  ];

  # Habilitar gestor de sesiones de usuario
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "jaraf";
    userEmail = "joserugel@gmail.com";
  };

  home.stateVersion = "26.05";
}
