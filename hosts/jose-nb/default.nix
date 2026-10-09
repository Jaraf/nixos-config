{ config, pkgs, lib, modulesPath, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko-vm.nix
    ../../common/hosts-apps.nix
    ../../common/nvidia.nix
  ];

  # Identidad de la red
  networking.hostName = "jose-nb"; 
  networking.networkmanager.enable = true;
  networking.hostId = "9d3e8f61";

  # Configuración de Zonas Horarias y Locale
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configuración del Caché Local de Nix (Substituters)
  nix.settings = {
    substituters = [
      "http://192.168.0.162:3143"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # Si tu caché local requiere una llave firmada propia, agrégala aquí abajo
    ];
  };

  # Bootloader y configuración de ZFS en el Initrd
  boot.initrd.systemd.emergencyAccess = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = true;
  boot.zfs.extraPools = [ "rpool" ];

  # Módulos del kernel requeridos para almacenamiento y QEMU
  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_pci"
    "ahci"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
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

  # Usuario del sistema
  users.users.jose = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.bash;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
