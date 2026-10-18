{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ mc ];

  system.activationScripts.rootMcConfig = {
    text = ''
      mkdir -p /root/.config/mc
      cp -f ${./.config/mc/root-ini} /root/.config/mc/ini
      cp -f ${./.config/mc/panels.ini} /root/.config/mc/panels.ini
      chmod 600 /root/.config/mc/*
    '';
  };

  system.activationScripts.rootMcConfig = {
    text = ''
      mkdir -p /root/.config/mc
      cp -f ${.config/mc/root-ini} /root/.config/mc/ini
      cp -f ${.config/mc/panels.ini} /root/.config/mc/panels.ini
      chmod 600 /root/.config/mc/*
    '';
  };
}
