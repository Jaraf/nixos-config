{ config, pkgs, lib, ... }:

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
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = true;

  boot.initrd.systemd.services."zfs-import-rpool" = {
    enable = true;
    description = lib.mkForce "Import ZFS pool rpool";
    wantedBy = lib.mkForce [ "sysroot.mount" ];
    before = lib.mkForce [ "sysroot.mount" ];
    after = lib.mkForce [ "udev-settle.service" ];
    requires = lib.mkForce [ "udev-settle.service" ];
    serviceConfig = lib.mkForce {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = lib.mkForce ''
      export PATH="$PATH:${pkgs.zfs}/bin:${pkgs.systemd}/bin"
      
      echo "Esperando a que los discos estén listos..."
      for i in {1..30}; do
        if zpool import -d /dev/disk/by-id -f rpool; then
          echo "¡Pool rpool importado con éxito!"
          exit 0
        fi
        sleep 1
      done
      
      echo "Error: No se pudo importar el pool rpool."
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
