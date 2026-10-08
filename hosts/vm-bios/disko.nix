{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            # Partición obligatoria para GRUB en discos GPT con BIOS
            boot = {
              size = "1M";
              type = "EF02"; # Partition type GUID para BIOS Boot Partition
              priority = 1; # Asegura que se cree primero
            };
            # Partición raíz ocupando el resto del disco
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
