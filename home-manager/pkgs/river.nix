{ pkgs, custom, ... }:

with pkgs;
[
  # Display Management
  wlr-randr

  # Wayland Compositors
  river
  rivercarro

  # Lockscreen and Idle Management
  swayidle
  swaylock

  # Notifications
  libnotify
  mako

  # Screenshot Tools
  grim
  custom.grimblast
  slurp

  # Clipboard Management
  cliphist
  wl-clipboard

  # Application Launchers
  wofi

  # Bars and Widgets
  waybar
  wttrbar

  # Wayland Portals
  xdg-desktop-portal-wlr
  xdg-desktop-portal-gtk

  # Custom Utilities
  custom.pyprland
]
