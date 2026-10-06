{
  disko = {
    devices = {
      disk = {
        nvme0 = {
          type = "disk";
          device = "/dev/disk/by-id/nvme-Predator_SSD_GM7_M.2_2TB_PSBH53400101881";
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
          device = "/dev/disk/by-id/nvme-Predator_SSD_GM7_M.2_2TB_PSBH53400102814";
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

