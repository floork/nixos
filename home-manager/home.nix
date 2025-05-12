{
  inputs,
  system,
  config,
  pkgs,
  isDesktop,
  ...
}:
let
  corePackages = import ./core-pkgs.nix {
    pkgs = pkgs;
    inputs = inputs;
    system = system;
  };
  desktopPackages =
    if isDesktop then
      import ./desktop-pkgs.nix {
        pkgs = pkgs;
        inputs = inputs;
        system = system;
      }
    else
      [ ];
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CURRENT_DESKTOP = "hyprland";
  };

  # User packages
  home.packages =
    corePackages
    ++ desktopPackages
    ++ (with pkgs; [
    ]);

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
