{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.sunshine ];
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true; # Muy recomendado si usas Wayland para permitir la captura de pantalla
  };
  systemd.user.services.sunshine.serviceConfig.Environment = [
    "MANGOHUD=0"
    "DISABLE_MANGOHUD=1"
  ];
}
