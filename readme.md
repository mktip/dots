# MKTI's NixOS dots

List of machines with existing configurations

> [!IMPORTANT]
> Git is a hard dependency to the commands below, make sure to have it installed or launch a nix shell containing git:
> ```bash
> $ nix --experimental-features "nix-command flakes" shell nixpkgs#git
> ```

## Machine: Jassas (Asus GA401)

On a new system, to bootstrap `home-manager`:
```bash
$ nix --experimental-features "nix-command flakes" develop git+https://github.com/mktip/dots
```


NixOS and home-manager configs are available under `machines/asus-ga401`:
```bash
$ sudo nixos-rebuild switch --flake "git+https://github.com/mktip/dots?dir=machines/asus-ga401#jassas"
$ home-manager switch --flake "git+https://github.com/mktip/dots?dir=machines/asus-ga401#mkti@jassas"
```
