{ config, pkgs, lib, modulesPath, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
    ../../common/hosts-apps.nix
  ];

  # Configuración de arranque BIOS (MBR)
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; # Ajusta al nombre de tu disco en Proxmox (ej. /dev/sda o /dev/vda)
  };

  # Permitir acceso directo a root
  users.users.root = {
    initialPassword = "1234";
    # O agrega tu clave SSH pública:
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..." ];
  };

  # Habilitar SSH para administración remota
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

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
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.11";
}
