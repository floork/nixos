# Nixos

## unstable nix channnel

```sh
# switch channel
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nixos-rebuild switch --upgrade
# show version
nixos-version
```

## home-manager

- stable

```sh
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-<NIX-OS-VERSION>.tar.gz home-manager
```

- unstable

```sh
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
```

- update the channel and rebuild

```sh
sudo nix-channel --update
sudo nixos-rebuild switch
```

## cursor can be set over lxappearance

- Future-cursor-theme in [here](cursor/Future-black-cursors.tar.gz)

## TODO

- fingerprint for `thinkpad`
- variety not working at the moment
