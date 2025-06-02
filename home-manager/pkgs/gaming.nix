{ pkgs, ... }:

with pkgs;
[

  # Desktop Applications
  bottles
  lutris
  prismlauncher

  # Wine
  wineWow64Packages.full
]
