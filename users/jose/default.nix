{ pkgs, ... }:

{
  home.username = "jose";
  home.homeDirectory = "/home/jose";

  imports = [
    ../../common/users-apps.nix
  ];

  # Tus aplicaciones de usuario cotidianas
  home.packages = with pkgs; [
    discord
    vscodium
  ];

  # Habilitar gestor de sesiones de usuario
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings.user.name = "jaraf";
    settings.user.email = "joserugel@gmail.com";
  };

  home.stateVersion = "26.05";
}
