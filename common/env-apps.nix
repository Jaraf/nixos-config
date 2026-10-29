{ config, pkgs, ... }:

{
  nix.settings = {
    # Ordenamos los substituters: primero tu Nginx local, luego el oficial como fallback
    substituters = [
      "http://192.168.0.162:3143"
      "https://cache.nixos.org"
    ];

    # Claves públicas confiables (como tu Nginx está cacheando cache.nixos.org, 
    # utiliza la firma criptográfica oficial de NixOS)
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  imports = [
    ./mc.nix
    ./onlyoffice.nix
  ];

  environment.systemPackages = with pkgs; [
    alsa-utils
    chromium
    curl
    dnsutils
    fastfetch
    firefox
    git
    home-manager
    htop
    kdePackages.kcalc
    kdePackages.sddm-kcm
    pciutils
    # pulseaudio
    usbutils
    vim
    vlc
    wget
  ];
}
