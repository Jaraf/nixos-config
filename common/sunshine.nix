{ config, pkgs, ... }:

{
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
  
    settings = {
      prep_cmd = ''
        export XDG_RUNTIME_DIR=/run/user/1000
        export WAYLAND_DISPLAY=wayland-1
        ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --mode 1920x1080
        # Nota: Para restaurar al cerrar, Sunshine ejecuta las líneas secuencialmente, 
        # pero por defecto 'prep_cmd' ejecuta todo al inicio o usa la lógica de retrollamada.
      '';
    };
  };
  systemd.user.services.sunshine.serviceConfig.Environment = [
    "MANGOHUD=0"
    "DISABLE_MANGOHUD=1"
  ];
}
