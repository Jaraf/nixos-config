{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sunshine ];
  services.sunshine = {
    enable = true;
    autoStart = true; # Opcional: si quieres que corra como servicio de sistema
    openFirewall = true; # Abre automáticamente los puertos necesarios en el firewall
  };
}
