{ config, pkgs, ... }:

let
  # Import module configurations
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

  # List of packages
  home.packages = with pkgs; [
    # Terminal Utilities
    curl
    exa
    fish
    gh
    htop
    neofetch
    pkg-config
    rustup
    util-linux
    wget
    zsh-autosuggestions
    zsh-syntax-highlighting

    # Fonts
    fira-code
    fira-code-symbols
    meslo-lg
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    # System Utilities
    arandr
    betterlockscreen
    bluez
    bluez-tools
    blueman
    docker
    gcc
    git
    inxi
    killall
    libiconv
    nixfmt
    openssl
    openssl.dev
    pipewire
    sqlite

    # Desktop Applications
    bottles
    discord
    firefox
    gimp
    insync
    kitty
    lutris
    mysql-workbench
    networkmanagerapplet
    notion-app-enhanced
    obs-studio
    obsidian
    peek
    prismlauncher
    qbittorrent
    remmina
    rofi
    steam
    xfce.thunar
    thunderbird
    variety
    yubikey-manager-qt

    # Development
    nodejs
    python3
    vscode

    # Hardware Info
    cpu-x
    dmidecode
    hardinfo
    hwinfo
    lshw

    # Miscellaneous
    copyq
    gnomeKeyringPkgs
    openrgb
    peek
    starship

    # Flatpak
    flatpak
  ];

  fonts.fontconfig.enable = true;

  # Program configurations
  programs = {
    fish = fishConfig;
    zsh = zshConfig;
    starship = starshipConfig;
    git = gitConfig;
  };

  # File configurations
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
      source = "/etc/nixos/scripts/powermenu.sh";
      target = "${config.home.homeDirectory}/.config/i3/powermenu.sh";
    };
    "modules/bashrc" = {
      source = "/etc/nixos/modules/bashrc";
      target = "${config.home.homeDirectory}/.bashrc";
    };
  };
}
