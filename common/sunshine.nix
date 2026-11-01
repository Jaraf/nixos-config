{ config, pkgs, ... }:

{
  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
  };
  
  # Forzar las variables y asegurar que reinicie si falla al arrancar por tiempo
  systemd.user.services.sunshine.serviceConfig = {
    Environment = [
      "MANGOHUD=0"
      "DISABLE_MANGOHUD=1"
      "XDG_RUNTIME_DIR=/run/user/1000"
      "WAYLAND_DISPLAY=wayland-1"
    ];
    Restart = "on-failure";
    RestartSec = "5s";
  };
}
