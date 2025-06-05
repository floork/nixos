{
  pkgs,
  inputs,
  system,
  ...
}:

rec {
  # Third-party or flake-only overrides
  grimblast = inputs.hyprland-contrib.packages.${system}.grimblast;
  pyprland = inputs.pyprland.packages.${system}.pyprland;
  zenBrowser = inputs.zen-browser.packages."${system}".default;
  swww = inputs.swww.packages."${system}".swww;
}
