{ config, pkgs, lib, modulesPath, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
    ../../common/hosts-apps.nix
  ];

  # Identidad de la red
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  # Configuración de Zonas Horarias y Locale
  time.timeZone = "America/Argentina/Buenos_Aires";
  i18n.defaultLocale = "en_US.UTF-8";

  # Bootloader y configuración de ZFS en el Initrd
  boot.initrd.systemd.emergencyAccess = true;

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

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
