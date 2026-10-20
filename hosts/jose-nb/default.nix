{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../common/nvidia.nix
    ../../common/env-apps.nix
  ];

  # Habilitar características experimentales de Nix a nivel de sistema
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader y configuración de ZFS en el Initrd
  boot.initrd.systemd.emergencyAccess = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = true;
  boot.zfs.extraPools = [ "rpool" ];

  # Gestor de arranque EFI y respaldo automático de /boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.extraInstallCommands = ''
    ${pkgs.rsync}/bin/rsync -av --delete /boot/ /boot/backup/
  '';

  # Intel
  hardware.cpu.intel.updateMicrocode = true;

  # Módulos del kernel reales detectados en hardware físico
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

  # Compilación del módulo msi-ec para el control de hardware MSI
  boot.extraModulePackages = with config.boot.kernelPackages; [ msi-ec ];

  # Módulos del kernel necesarios para el control de hardware MSI
  boot.kernelModules = [ "msi_ec" "ec_sys" ];
  boot.kernelParams = [ "ec_sys.write_support=1" ]; # Pass write_support=1 to the ec_sys module

  # MControlCenter
  environment.systemPackages = [ pkgs.mcontrolcenter ];
  services.dbus.packages = [ pkgs.mcontrolcenter ]; # Without this, MControlCenter won't be able to talk to its background helper service

  # Habilitar firmware no libre y redistribuible para Wi-Fi, Bluetooth y controladores
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Audio (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # KDE Plasma
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  programs.kde-pim.enable = false; # PIM deshabilitado (Korganizer, Kmail, etc)

  # Configuración de Zonas Horarias y Locale
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "en_US.UTF-8";

  # Identidad de la red
  networking.hostName = "jose-nb"; 
  networking.networkmanager.enable = true;
  networking.hostId = "9d3e8f61";

  # Usuario del sistema
  users.users.jose = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "bluetooth" ];
    shell = pkgs.bash;
  };

  # Upgrade automatico
  system.autoUpgrade = {
    enable = true;
    flake = "github:jaraf/nixos-config#jose-nb";
    dates = "Sun *-*-* 05:00:00";
    allowReboot = true;
    randomizedDelaySec = "30min";
    flags = [
      "--refresh"
      "--no-write-lock-file"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.11";
}
