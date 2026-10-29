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
      prep_cmd = ''
        ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --mode 1920x1080
        ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --mode 2560x1600
      '';
    };
  };
  systemd.user.services.sunshine.serviceConfig.Environment = [
    "MANGOHUD=0"
    "DISABLE_MANGOHUD=1"
  ];
}
