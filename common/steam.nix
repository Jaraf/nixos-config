{ config, pkgs, lib, ... }:

{
  # Configuración de Steam con soporte para MangoHUD

  # Definir variables de ruta
  # WORKSHOP_DIR="$HOME/.local/share/Steam/steamapps/workshop/content/1677280"
  # GAME_SUBS_DIR="$HOME/.local/share/Steam/steamapps/compatdata/1677280/pfx/drive_c/users/steamuser/Documents/My Games/Company of Heroes 3/mods/extension/subscriptions"
  # Crear el directorio de destino por si acaso
  # mkdir -p "$GAME_SUBS_DIR"
  # Copiar/Vincular los mapas que ya descargó Steam a la carpeta del juego
  # cp -rfu "$WORKSHOP_DIR"/* "$GAME_SUBS_DIR"/

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
#    
#    extraCompatPackages = with pkgs; [
#      mangohud
#    ];
  };
}
