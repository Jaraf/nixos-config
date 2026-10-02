{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    steam
    vlc
  ];

  # Esto copia tus archivos locales del repositorio hacia la ruta ~/.config/mc/
  xdg.configFile."mc/ini".source = .config/mc/ini;
  xdg.configFile."mc/panel.ini".source = .config/mc/panel.ini;
}
