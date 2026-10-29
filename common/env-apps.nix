{ config, pkgs, ... }:

{
  # 1. Habilitar la recolección de basura automática de forma periódica
  nix.gc = {
    automatic = true;
    dates = "weekly"; # O "daily" si lo prefieres
    options = "--delete-older-than 7d"; # Borra generaciones de más de 7 días
  };

  # 2. Limitar cuántas generaciones se guardan en el menú de arranque (y por ende en /boot)
  # Esto evita que se acumulen docenas de kernels viejos ocupando espacio EFI
  boot.loader.systemd-boot.configurationLimit = 10; 

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
