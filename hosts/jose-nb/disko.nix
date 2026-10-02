nvme0 = {
        type = "disk";
        device = "/dev/disk/by-id/tu-primer-nvme-id";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot"; # El punto de montaje principal
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zpool";
                pool = "rpool";
              };
            };
          };
        };
      };
      nvme1 = {
        type = "disk";
        device = "/dev/disk/by-id/tu-segundo-nvme-id";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                # En lugar de /boot2, se maneja como EFI secundaria 
                # que NixOS sincronizará automáticamente
                mountpoint = "/boot/backup"; 
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zpool";
                pool = "rpool";
              };
            };
          };
        };
      };
