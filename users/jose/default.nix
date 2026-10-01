{ pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";

  imports = [
    ../../modules/user-common.nix
  ];

# Tus aplicaciones de usuario cotidianas
  home.packages = with pkgs; [
    discord
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
