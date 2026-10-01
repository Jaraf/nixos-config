{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jose-nb"; 
  networking.networkmanager.enable = true;

  # Configuración de Zonas Horarias y Locale
  time.timeZone = "America/Argentina/Buenos_Aires"; # Cambia la tuya si es necesario
  i18n.defaultLocale = "en_US.UTF-8";

  # Entorno gráfico: KDE Plasma con Wayland
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  {
    imports = [
      ../../common/nvidia.nix
    ];
  
    # Configuración de Hardware Híbrido (Intel + NVIDIA RTX 4090)
    # Aquí dejas solo lo que es exclusivo de este equipo (como los BusID del modo Prime offload)
    hardware.nvidia.prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  }

  # Audio (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Usuario del sistema
  users.users.jose = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh; # O bash
  };

  # Paquetes base del sistema
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    vim
  ];

  system.stateVersion = "26.05"; # Versión inicial del sistema
}
