{ config, pkgs, ... }:

let
  bashConfig = import ./modules/bash.nix { inherit config pkgs; };
  fishConfig = import ./modules/fish.nix { inherit config pkgs; };
  zshConfig = import ./modules/zsh.nix { inherit config pkgs; };
  starshipConfig = import ./modules/starship.nix { inherit config pkgs; };
  neofetchConfig = import ./modules/neofetch.nix { inherit config pkgs; };
  kittyConfig = import ./modules/kitty.nix { inherit config pkgs; };
in

{
  home.username = "floork";
  home.homeDirectory = "/home/floork";
  home.stateVersion = "23.05";

  home.packages = [
    pkgs.flatpak
    pkgs.kitty
    pkgs.gparted
    pkgs.discord
    pkgs.spotify
    pkgs.bottles
    pkgs.steam
    pkgs.vscode
    pkgs.lutris
    pkgs.thunderbird
    pkgs.qbittorrent
    pkgs.neofetch
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.meslo-lg
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-emoji
    pkgs.firefox
  ];

  fonts.fontconfig.enable = true;

  programs.bash = bashConfig;
  programs.fish = fishConfig;
  programs.zsh = zshConfig;
  programs.starship = starshipConfig;
  home.file.".config/kitty/kitty.conf" = kittyConfig;
  home.file.".config/neofetch/config.conf" = neofetchConfig;
}
