{params, ...}: {
  boot.initrd.availableKernelModules = ["nvme"];
  boot.kernelModules = ["kvm-amd"];

  boot.initrd.kernelModules = [];
  boot.extraModulePackages = [];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    root = {
      device = params.fs.luksDisk;
      preLVM = true;
    };
  };
}
