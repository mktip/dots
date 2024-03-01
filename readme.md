# MKTI's NixOS dots

List of machines for whom a configuration exists

## Machine: Jassas (Asus GA401)

On a new system, to bootstrap `home-manager`:
```bash
$ nix --experimental-features "nix-command flakes" shell nixpkgs#git
$ git clone https://github.com/mktip/dots && cd dots
$ nix --experimental-features "nix-command flakes" develop
```


NixOS and home-manager configs are available under `machines/asus-ga401`:
```bash
$ sudo nixos-rebuild switch --flake ./machines/asus-ga401#jassas
$ home-manager switch --flake ./machines/asus-ga401#mkti@jassas
```
