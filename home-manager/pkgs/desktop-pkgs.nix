{ pkgs, ... }:
with pkgs;
[
  # System Utilities
  solaar

  # Desktop Applications
  bottles
  lutris
  piper
  prismlauncher
  qbittorrent

  # Development
  ## gamedev
  libratbag

  # Miscellanious
  openrgb
  duplicati

  # Wine
  wineWow64Packages.full

  # keyboard
  wally-cli

  # wezterm
  simple-scan
]
