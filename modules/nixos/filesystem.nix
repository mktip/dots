{
  params,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = params.fs.swapSize;
    }
  ];

  fileSystems."/" = {
    device = params.fs.btrfsDisk;
    fsType = "btrfs";
    options = ["subvol=n${params.fs.rootSubvol}" "compress=zstd" "noatime"];
  };

  fileSystems."/home" = {
    device = params.fs.btrfsDisk;
    fsType = "btrfs";
    options = ["subvol=${params.fs.homeSubvol}" "compress=zstd" "noatime"];
  };

  fileSystems."/boot" = {
    device = params.fs.bootDisk;
    fsType = "vfat";
  };
}
