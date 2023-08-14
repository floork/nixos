# Nixos

## How to use

1. clone the repo as `/etc/nixos`

1.1 save the hardware-configuration.nix

```sh
sudo cp /etc/nixos/hardware-configuration.nix ~/
```

1.2 rm the /etc/nixos

```sh
sudo rm /etc/nixos
```

1.3 readd the hardware-configuration

```sh
sudo cp ~/hardware-configuration.nix /etc/nixos
```

2. install home-manager

2.1 add the channel

stable

```sh
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-<NIX-OS-VERSION>.tar.gz home-manager
```

or unstable

```sh
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
```

2.2 updated the channels

```sh
sudo nix-channel --update
```

2.3 apply everything

```sh
sudo nixos-rebuild switch
```

[todos](TODO.md)