{ pkgs, custom, ... }:

with pkgs;
[
  home-manager
  custom.zenBrowser

  # Hyprland ecosystem
  dunst
  fuzzel
  grim
  custom.grimblast
  hyprcursor
  hypridle
  hyprland-protocols
  hyprlock
  hyprpaper
  custom.pyprland
  slurp
  swaybg
  walker
  waybar
  waypaper
  wl-clipboard
  wofi
  wttrbar
  xdg-desktop-portal-hyprland
  kdePackages.xwaylandvideobridge
]
