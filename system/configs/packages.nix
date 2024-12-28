{
  inputs,
  config,
  pkgs,
  ...
}:

{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    nix-ld.enable = true;
    zsh = {
      enable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3" # for etcher
  ];

  # Fonts
  fonts.packages =
    with pkgs;
    [
      # Include all Nerd fonts
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
