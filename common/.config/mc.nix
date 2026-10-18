{ pkgs, ... }:

{
#  home.packages = with pkgs; [
#  ];

  # Esto copia tus archivos locales del repositorio hacia la ruta ~/.config/mc/
  xdg.configFile."mc/ini".source = .config/mc/ini;
  xdg.configFile."mc/panels.ini".source = .config/mc/panels.ini;
}
