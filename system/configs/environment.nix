{
  pkgs,
  ...
}:

{
  environment = {
    variables = {
      EDITOR = "nvim";
      XDG_CURRENT_DESKTOP = "wlroots";
      XDG_SESSION_TYPE = "wayland";
    };
    sessionVariables = rec {
      # Hint Electron apps to use wayland
      NIXOS_OZONE_WL = "1";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };

    shells = with pkgs; [ zsh ];

    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [
      coreutils
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
}
