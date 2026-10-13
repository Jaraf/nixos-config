{ config, pkgs, lib, modulesPath, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disko.nix
    ../../common/hosts-apps.nix
  ];

  # Configuración explícita para evitar duplicación en mirroredBoots
  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = lib.mkForce [ "/dev/sda" ];
  };

  # Permitir acceso directo a root
  users.users.root = {
    initialPassword = "1234";
    # O agrega tu clave SSH pública:
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..." ];
  };

  # Habilitar el agente de QEMU para comunicación directa con Proxmox
  services.qemuGuest.enable = true;

  # Habilitar SSH para administración remota
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  # Identidad de la red
  networking = {
    hostName = "nixos"; 
    networkmanager.enable = true;
    enableIPv6 = false;
    # useDHCP = false;
    # defaultGateway = "10.92.70.1";
    # nameservers = [ "10.92.70.1" ];
    # interfaces.eth0 = {
      # ipv4.addresses = [{
        # address = "10.92.70.19";
        # prefixLength = 24;
      # }];
    # };
    # Harmonia - Abrir el puerto 5000 en el firewall para acceso en la LAN
    # firewall.allowedTCPPorts = [ 5000 ];
  };

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
