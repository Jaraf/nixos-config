{
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/disk/by-id/tu-primer-nvme-id";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
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
            boot = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                # Disko permite manejar particiones EFI secundarias para redundancia
                mountpoint = "/boot2";
                mountOptions = [ "umask=0077" ];
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
    };
    zpool = {
      rpool = {
        type = "zpool";
        mode = "mirror"; # Configura el RAID 1 automático entre los dos discos
        rootFsOptions = {
          compression = "lz4";
          acltype = "posixacl";
          xattr = "sa";
          normalization = "formD";
          mountpoint = "none";
        };
        datasets = {
          "root" = {
            type = "zfs_filesystem";
            mountpoint = "/";
          };
          "nix" = {
            type = "zfs_filesystem";
            mountpoint = "/nix";
          };
          "home" = {
            type = "zfs_filesystem";
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
