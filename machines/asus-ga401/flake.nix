{
  description = "Asus G401 University Laptop";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Neovim in nix
    nixvim.url = "github:nix-community/nixvim/nixos-23.11";

    # Run unpatched binaries
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # For quick hardware configuration (asus ga401)
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    params = {
      system = "x86_64-linux";
      timeZone = "Europe/Istanbul";

      hostname = "jassas";
      username = "mkti";
      fullname = "Mohammad KT. Issa";

      shell = "fish";
      terminal = "foot";
      fs = {
        luksDisk = "/dev/disk/by-uuid/cc9817b5-da28-4c7b-b3db-e72432eec270";
        btrfsDisk = "/dev/disk/by-uuid/7c9bc6f5-8a1d-4f21-afa0-a44f806eafba";
        bootDisk = "/dev/disk/by-uuid/EFE3-A253";
        rootSubvol = "nixos";
        homeSubvol = "home";
        swapSize = 16 * 1024;
      };
    };
  in {
    formatter = nixpkgs.legacyPackages.${params.system}.alejandra;

    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    nixosConfigurations = {
      ${params.hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs params;};
        modules = [
          inputs.hardware.nixosModules.asus-zephyrus-ga401

          ./modules/nixos/nix.nix

          ./modules/nixos/boot.nix
          ./modules/nixos/filesystem.nix
          ./modules/nixos/network.nix
          ./modules/nixos/services.nix
          ./modules/nixos/users.nix

          ./modules/nixos/global-packages.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    homeConfigurations = {
      "${params.username}@${params.hostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${params.system}; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs params;};
        modules = [
          ./modules/home-manager/home.nix
          ./modules/home-manager/commandline.nix
        ];
      };
    };
  };
}
