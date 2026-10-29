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
        ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.eDP-1.mode.15
        ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.eDP-1.mode.1
      '';
    };
  };
  
  systemd.user.services.sunshine.serviceConfig.Environment = [
    "MANGOHUD=0"
    "DISABLE_MANGOHUD=1"
  ];
}
