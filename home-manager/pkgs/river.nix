{ pkgs, custom, ... }:

with pkgs;
[
  dunst
  grim
  custom.grimblast
  slurp
  custom.pyprland
  waybar
  wl-clipboard
  wofi
  wttrbar

  # wayfire
  swayidle
  river
  rivercarro
]
