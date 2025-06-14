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
  home.stateVersion = "24.11";
  home.username = "floork";
  home.homeDirectory = "/home/floork";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
    homedir = "${config.home.homeDirectory}/.gnupg";
    mutableKeys = true;
    mutableTrust = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    extraConfig = ''
      # Changed this line to point to the graphical pinentry:
      pinentry-program ${pkgs.pinentry-gtk2}/bin/pinentry-gtk-2
      # You might not need pinentry-tty/ttyname with graphical pinentry,
      # but keeping them won't hurt. You can remove them if it works without.
      # pinentry-tty ${builtins.getEnv "TTY"} # Usually not needed for graphical
      # ttyname ${builtins.getEnv "TTY"}       # Usually not needed for graphical

      allow-loopback-pinentry
      # allow-emacs-pinentry # Keep if you use Emacs' built-in GPG features

      default-cache-ttl 600
      max-cache-ttl 7200
      default-cache-ttl-ssh 600
      max-cache-ttl-ssh 7200
    '';
  };

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
    size = 12;
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
