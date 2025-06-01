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

  swayidle
  river
  rivercarro

  xdg-desktop-portal-wlr
  xdg-desktop-portal-gtk

  wlr-randr
]
