{ config, pkgs, ... }:

{
#  environment.systemPackages = [ pkgs.sunshine ];
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true; # Muy recomendado si usas Wayland para permitir la captura de pantalla

    # Configuración de comandos personalizados para antes y después del streaming
    settings = {
      # Lista de comandos a ejecutar: [ "comando_inicio", "comando_cierre" ]
      # Ejemplo usando wlr-randr para cambiar la resolución de tu pantalla (ej. eDP-1)
      prep_cmd = [
        # Al iniciar el streaming: cambia a 1920x1080
        "${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --mode 1920x1080"
        # Al cerrar el streaming: restaura a la nativa 2560x1600
        "${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --mode 2560x1600"
      ];
    };
  };
  systemd.user.services.sunshine.serviceConfig.Environment = [
    "MANGOHUD=0"
    "DISABLE_MANGOHUD=1"
  ];
}
