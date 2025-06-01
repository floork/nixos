{
  inputs,
  system,
  config,
  pkgs,
  hostRole,
  ...
}:
let
  packages = import ./pkgs/default.nix {
    inherit
      pkgs
      inputs
      system
      hostRole
      ;
  };

in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CURRENT_DESKTOP = "wlroots";
    XDG_SESSION_TYPE = "wayland";
  };

  # User packages
  home.packages = packages;

  fonts.fontconfig.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };
  };
}
