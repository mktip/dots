# MKTI's NixOS dots

List of machines with existing configurations

## Machine: Jassas (Asus GA401)

On a new system, to bootstrap `home-manager`:
```bash
$ nix --experimental-features "nix-command flakes" flake clone git+https://github.com/mktip/dots --dest ./dots
$ nix --experimental-features "nix-command flakes" develop ./dots
$ cd dots/
```


NixOS and home-manager configs are available under `machines/asus-ga401`:
```bash
$ sudo nixos-rebuild switch --flake ./machines/asus-ga401#jassas
$ home-manager switch --flake ./machines/asus-ga401#mkti@jassas
```
