{
  disko = {
    devices = {
      disk = {
        nvme0 = {
          type = "disk";
          # device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
          device = "/dev/sda";
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
            };
          };
        };
      };
    };
  };
}
