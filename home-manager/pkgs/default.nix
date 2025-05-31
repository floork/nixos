{
  pkgs,
  inputs,
  system,
  hostRole,
  ...
}:

let
  lib = pkgs.lib;
  custom = import ./custom-packages.nix {
    inherit
      pkgs
      inputs
      system
      ;
  };

  hyprlandPkgs = import ./hyprland.nix { inherit pkgs custom; };
  riverPkgs = import ./river.nix { inherit pkgs custom; };
  terminalPkgs = import ./terminal-utils.nix { inherit pkgs; };
  systemPkgs = import ./system-utils.nix { inherit pkgs; };
  desktopPkgs = import ./desktop-apps.nix { inherit pkgs custom; };
  gamingPkgs = import ./gaming.nix { inherit pkgs; };
  devPkgs = import ./development.nix { inherit pkgs; };
  hwPkgs = import ./hardware-info.nix { inherit pkgs; };
  miscPkgs = import ./misc.nix { inherit pkgs; };

  laptopOnlyPkgs =
    if hostRole == "laptop" then import ./laptop-pkgs.nix { inherit pkgs inputs system; } else [ ];
  desktopOnlyPkgs =
    if hostRole == "desktop" then import ./desktop-pkgs.nix { inherit pkgs inputs system; } else [ ];
in

lib.concatLists [
  hyprlandPkgs
  riverPkgs
  terminalPkgs
  systemPkgs
  desktopPkgs
  gamingPkgs
  devPkgs
  hwPkgs
  miscPkgs
  laptopOnlyPkgs
  desktopOnlyPkgs
]
