{ config, pkgs, ... }:

{
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
  
    # Comandos de preparación y limpieza globales usando kscreen-doctor
    settings = {
      prep_cmd = ''
        ${pkgs.kscreen}/bin/kscreen-doctor output.eDP-1.mode.15
        ${pkgs.kscreen}/bin/kscreen-doctor output.eDP-1.mode.1
      '';
    };
  };
  
  # Mantenemos el entorno limpio de MangoHud
  systemd.user.services.sunshine.serviceConfig.Environment = [
    "MANGOHUD=0"
    "DISABLE_MANGOHUD=1"
  ];
}
