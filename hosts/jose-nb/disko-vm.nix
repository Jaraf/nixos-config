{
  disko = {
    devices = {
      disk = {
        nvme0 = {
          type = "disk";
          device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
          content = {
            type = "gpt";
            partitions = {
              esp = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            };
          };
        };
        nvme1 = {
          type = "disk";
          device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi1";
          content = {
            type = "gpt";
            partitions = {
              esp = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot/backup";
                };
              };
              zfs = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            };
          };
        };
      };
      zpool = {
        rpool = {
          type = "zpool";
          mode = "mirror";
          rootFsOptions = {
            compression = "zstd";
            "com.sun:auto-snapshot" = "false";
          };
          # Declaramos explícitamente los miembros del espejo basados en las particiones creadas
          # (disko busca por defecto el nombre de la partición 'zfs' en cada disco)
          datasets = {
            root = {
              type = "zfs_fs";
              mountpoint = "/";
            };
            home = {
              type = "zfs_fs";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}
