{ config, pkgs, ... }:

let
  # Install GNOME Keyring and its dependencies
  gnomeKeyringPkgs = pkgs.buildEnv {
    name = "gnome-keyring-packages";
    paths = [ pkgs.gnome3.gnome-keyring ];
  };

  # Define firewall rules to allow KDE Connect
  firewallRules = {
    allowedServices =
      [ "kdeconnect" ]; # Create a service definition for KDE Connect
    kdeconnect = {
      description = "KDE Connect communication";
      localPort = [ 1714 1716 ]; # UDP and TCP ports used by KDE Connect
      remotePort = [ 1714 1716 ];
      allowedTCPPorts = [ 1716 ]; # You can restrict this further if needed
      allowedUDPPorts = [ 1714 ];
    };
  };

in {
  home.username = "floork";
  home.homeDirectory = "/home/floork";
  home.stateVersion = "23.05";
  # autoUpgrade = true;

  home.sessionVariables = {
    EDITOR = "vim";
    XDG_CURRENT_DESKTOP = "Sway";
  };

  # List of packages
  home.packages = with pkgs; [
    # hyprland stuff
    dunst
    swaylock
    waybar
    waypaper
    wl-clipboard
    wofi

    # Terminal Utilities
    curl
    lsd
    tree
    fish
    gh
    htop
    neofetch
    pkg-config
    rustup
    tldr
    util-linux
    vim
    wget
    zsh-autosuggestions
    zsh-syntax-highlighting

    # System Utilities
    arandr
    bitwarden
    bitwarden-cli
    bluez
    bluez-tools
    blueman
    brightnessctl
    docker
    emojipick
    feh
    fprintd
    gcc
    git
    graphviz
    gparted
    inxi
    kdeconnect
    killall
    libiconv
    libnotify
    lxappearance
    nixfmt
    openssl
    openssl.dev
    p7zip
    pavucontrol
    pipewire
    playerctl
    sqlite
    translate-shell
    trash-cli
    xorg.xkill

    # Desktop Applications
    brave
    chromium
    discord
    drawio
    element-desktop
    flameshot
    gimp
    insync
    kitty
    libsForQt5.kruler
    libreoffice
    networkmanagerapplet
    obsidian
    prismlauncher
    qbittorrent
    remmina
    spotify
    xfce.thunar
    thunderbird
    variety
    yubikey-manager-qt
    beekeeper-studio
    lua
    lua-language-server
    nodejs
    openjdk
    python3
    vscode

    # NeoVim
    deno
    fzf
    gnumake
    grip
    lazygit
    luajitPackages.lua-lsp
    neovim
    pandoc
    ripgrep
    unzip
    vimPlugins.telescope-fzf-native-nvim

    # Hardware Info
    cpu-x
    dmidecode
    hardinfo
    hwinfo
    lshw
    ntfs3g

    # Miscellaneous
    copyq
    duplicati
    gnomeKeyringPkgs
    gnupg
    peek
    pinentry
    starship

    # Flatpak
    flatpak
  ];

  fonts.fontconfig.enable = true;

}
