{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.sunshine
  ];
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true; # Muy recomendado si usas Wayland para permitir la captura de pantalla
  };
}
