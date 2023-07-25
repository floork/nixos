{ config, pkgs, ... }:

let
  bashConfig = import ./modules/bash.nix { inherit config pkgs; };
  fishConfig = import ./modules/fish.nix { inherit config pkgs; };
  zshConfig = import ./modules/zsh.nix { inherit config pkgs; };
  starshipConfig = import ./modules/starship.nix { inherit config pkgs; };
  neofetchConfig = import ./modules/neofetch.nix { inherit config pkgs; };
  kittyConfig = import ./modules/kitty.nix { inherit config pkgs; };
  i3Config = import ./modules/i3.nix { inherit config pkgs; };
  gitConfig = import ./modules/git.nix { inherit config pkgs; };

  # Install GNOME Keyring and its dependencies
  gnomeKeyringPkgs = pkgs.buildEnv {
    name = "gnome-keyring-packages";
    paths = [ pkgs.gnome3.gnome-keyring ];
  };

in {
  home.username = "floork";
  home.homeDirectory = "/home/floork";
  home.stateVersion = "23.05";

  home.sessionVariables = { EDITOR = "vim"; };

  # environment.cursor.theme = "/path/to/cursor/themes/MyCursorTheme";

  home.packages = with pkgs; [
    flatpak
    kitty
    gparted
    discord
    spotify
    bottles
    steam
    vscode
    lutris
    thunderbird
    qbittorrent
    neofetch
    zsh-autosuggestions
    zsh-syntax-highlighting
    fira-code
    fira-code-symbols
    meslo-lg
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    firefox
    gimp
    variety
    notion-app-enhanced
    gnomeKeyringPkgs
    obsidian
    insync
    libsForQt5.kruler
    nixfmt
    rustup
  ];

  fonts.fontconfig.enable = true;

  programs = {
    bash = bashConfig;
    fish = fishConfig;
    zsh = zshConfig;
    starship = starshipConfig;
    git = gitConfig;
  };

  home.file = {
    ".config/kitty/kitty.conf" = kittyConfig;
    ".config/neofetch/config.conf" = neofetchConfig;
    ".config/i3/config" = i3Config;
    ".config/rofi/config.rasi" = {
      text = ''
        @theme "/nix/store/gsya3v0afklrwkcxv4drzkdw5npvpcfa-rofi-1.7.5/share/rofi/themes/arthur.rasi"
      '';
    };
    "modules/powermenu.sh" = {
      source = "/etc/nixos/modules/powermenu.sh";
      target = "${config.home.homeDirectory}/.config/i3/powermenu.sh";
    };
  };

}
