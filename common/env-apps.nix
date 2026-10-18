{ config, pkgs, ... }:

{
  imports = [
    /common/onlyoffice.nix
  ];

  environment.systemPackages = with pkgs; [
    alsa-utils
    curl
    dnsutils
    fastfetch
    git
    home-manager
    htop
    kdePackages.kcalc
    kdePackages.sddm-kcm
    mc
    pciutils
    usbutils
    vim
    wget
  ];

  system.activationScripts.rootMcConfig = {
    text = ''
      mkdir -p /root/.config/mc
      cp -f ${.config/mc/root-ini} /root/.config/mc/ini
      cp -f ${.config/mc/panels.ini} /root/.config/mc/panels.ini
      chmod 600 /root/.config/mc/*
    '';
  };
}
