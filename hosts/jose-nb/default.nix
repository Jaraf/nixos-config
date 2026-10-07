{ config, pkgs, ... }:

{
  hardware.cpu.intel.updateMicrocode = true;
  imports = [
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
  boot.initrd.supportedFilesystems = [ "zfs" ]; # <-- Esto es clave para que el initrd pueda importar pools antes de montar la raíz
  # boot.zfs.devNodes = "/dev/disk/by-id";
  boot.zfs.forceImportRoot = true;

  # Forzar la importación explícita con espera para udev en el initrd
  boot.initrd.systemd.services."zfs-import-rpool" = {
    script = ''
      ${pkgs.systemd}/bin/udevadm settle || true
      
      for i in {1..30}; do
        if [ -e /dev/sda ] && [ -e /dev/sdb ]; then
          if ${pkgs.zfs}/bin/zpool import -d /dev/sda -d /dev/sdb -f rpool; then
            echo "Pool rpool imported successfully!"
            exit 0
          fi
        fi
        sleep 1
      done
      
      echo "Failed to import rpool after multiple attempts."
      exit 1
    '';
    before = [ "sysroot.mount" ];
    requiredBy = [ "sysroot.mount" ];
    after = [ "udev.service" ];
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
