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

  # Bootloader y sincronización del espejo EFI en ambos NVMe
  boot.initrd.systemd.emergencyAccess = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = true;

  # Módulos exactos descubiertos por el perfil de QEMU y almacenamiento
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

  # Desactivar explícitamente el servicio nativo de importación del initrd para evitar conflictos
  boot.initrd.systemd.services."zfs-import-rpool".enable = false;

# Nuestro servicio personalizado con reintentos robustos y espera de udev
  boot.initrd.systemd.services."zfs-import-custom" = {
    description = "Custom import ZFS pool rpool with retry";
    wantedBy = [ "sysroot.mount" ];
    before = [ "sysroot.mount" ];
    after = [ "systemd-udev-settle.service" ];
    requires = [ "systemd-udev-settle.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      export PATH="$PATH:${pkgs.zfs}/bin:${pkgs.systemd}/bin"
      
      echo "Esperando a que los discos por ID estén listos..."
      for i in {1..40}; do
        if [ -e /dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-part1 ] && zpool import -d /dev/disk/by-id -f rpool; then
          echo "¡Pool rpool importado con éxito!"
          exit 0
        fi
        sleep 1
      done
      
      echo "Error: No se pudo importar el pool rpool tras varios intentos."
      exit 1
    '';
  };

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
