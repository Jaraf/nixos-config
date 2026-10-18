{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ mc ];

  system.activationScripts.rootMcConfig = {
    text = ''
      mkdir -p /root/.config/mc
      cp -f ${/common/.config/mc/root-ini} /root/.config/mc/ini
      cp -f ${/common/.config/mc/panels.ini} /root/.config/mc/panels.ini
      chmod 600 /root/.config/mc/*
    '';
  };

  xdg.configFile."mc/ini".source = /common/.config/mc/ini;
  xdg.configFile."mc/panels.ini".source = /common/.config/mc/panels.ini;
}
