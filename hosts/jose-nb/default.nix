{ config, pkgs, lib, modulesPath, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../common/hosts-apps.nix
    ../../common/nvidia.nix
  ];

  # Única definición de paquetes del sistema combinados
  environment.systemPackages = with pkgs; [
    pulseaudio     # Provee pactl para compatibilidad con apps que lo reclaman
    mangohud       # Monitor de rendimiento en pantalla
    mcontrolcenter # Interfaz gráfica de control para portátiles MSI
  ];

  # Forzar la inyección global de MangoHUD en aplicaciones y Steam
  environment.variables = {
    MANGOHUD = "1";
  };

  # Identidad de la red
  networking.hostName = "jose-nb"; 
  networking.networkmanager.enable = true;
  networking.hostId = "9d3e8f61";

  # Configuración de Zonas Horarias y Locale
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "en_US.UTF-8";

  # Bootloader y configuración de ZFS en el Initrd
  boot.initrd.systemd.emergencyAccess = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = true;
  boot.zfs.extraPools = [ "rpool" ];

  # Habilitar firmware no libre y redistribuible para Wi-Fi, Bluetooth y controladores
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Compilación del módulo msi-ec para el control de hardware MSI
  boot.extraModulePackages = with config.boot.kernelPackages; [
    msi-ec
  ];

  # Módulos del kernel necesarios para el control de hardware MSI
  boot.kernelModules = [ "msi_ec" "ec_sys" ];

  # Módulos del kernel reales detectados en tu hardware físico
  boot.initrd.availableKernelModules = [
    "vmd"
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
    "zfs"
  ];

  # Gestor de arranque EFI y respaldo automático de /boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.extraInstallCommands = ''
    ${pkgs.rsync}/bin/rsync -av --delete /boot/ /boot/backup/
  '';

  # Entorno gráfico: KDE Plasma con Wayland
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Audio (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Configuración de Steam con soporte para MangoHUD

  # Definir variables de ruta
  # WORKSHOP_DIR="$HOME/.local/share/Steam/steamapps/workshop/content/1677280"
  # GAME_SUBS_DIR="$HOME/.local/share/Steam/steamapps/compatdata/1677280/pfx/drive_c/users/steamuser/Documents/My Games/Company of Heroes 3/mods/extension/subscriptions"
  # Crear el directorio de destino por si acaso
  # mkdir -p "$GAME_SUBS_DIR"
  # Copiar/Vincular los mapas que ya descargó Steam a la carpeta del juego
  # cp -rfu "$WORKSHOP_DIR"/* "$GAME_SUBS_DIR"/

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    
    extraCompatPackages = with pkgs; [
      mangohud
    ];
  };

  programs.kde-pim.enable = false;

  # Habilitar características experimentales de Nix a nivel de sistema
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Usuario del sistema
  users.users.jose = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "bluetooth" ];
    shell = pkgs.bash;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.11";
}
