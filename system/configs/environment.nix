{
  pkgs,
  ...
}:

{
  environment = {
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = rec {
      # Hint Electron apps to use wayland
      NIXOS_OZONE_WL = "1";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };

    shells = with pkgs; [ zsh ];

    pathsToLink = [ "/libexec" ];
    systemPackages = with pkgs; [ coreutils ];
  };
}
