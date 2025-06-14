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

  riverPkgs = import ./river.nix { inherit pkgs custom; };
  terminalPkgs = import ./terminal-utils.nix { inherit pkgs; };
  systemPkgs = import ./system-utils.nix { inherit pkgs; };
  desktopPkgs = import ./desktop-apps.nix { inherit pkgs custom; };
  devPkgs = import ./development.nix { inherit pkgs; };
  hwPkgs = import ./hardware-info.nix { inherit pkgs; };

  laptopOnlyPkgs =
    if hostRole == "laptop" then import ./laptop-pkgs.nix { inherit pkgs inputs system; } else [ ];
  desktopOnlyPkgs =
    if hostRole == "desktop" then
      import ./desktop-pkgs.nix { inherit pkgs inputs system; } import ./gaming.nix { inherit pkgs; }
    else
      [ ];
in

lib.concatLists [
  riverPkgs
  terminalPkgs
  systemPkgs
  desktopPkgs
  devPkgs
  hwPkgs
  laptopOnlyPkgs
  desktopOnlyPkgs
]
