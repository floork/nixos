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
  rofiConfig = import ./modules/rofi.nix { inherit config pkgs; };

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

  home.sessionVariables = { EDITOR = "vim"; };

  # List of packages
  home.packages = with pkgs; [
    # Terminal Utilities
    curl
    lsd # error: 'exa' has been removed because it is unmaintained upstream. Consider using 'eza', a maintained fork
    tree
    fish
    gh
    htop
    neofetch
    pkg-config
    rustup
    util-linux
    vim
    wget
    zsh-autosuggestions
    zsh-syntax-highlighting

    # System Utilities
    arandr
    betterlockscreen
    bitwarden
    bitwarden-cli
    bluez
    bluez-tools
    blueman
    docker
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

    # Desktop Applications
    bottles
    brave
    discord
    flameshot
    gimp
    insync
    kitty
    lutris
    mysql-workbench
    networkmanagerapplet
    obs-studio
    obsidian
    peek
    prismlauncher
    qbittorrent
    remmina
    rofi
    steam
    spotify
    xfce.thunar
    thunderbird
    variety
    yubikey-manager-qt

    # Development
    lua
    openjdk
    nodejs
    python3
    virt-manager
    vscode

    # Hardware Info
    cpu-x
    dmidecode
    hardinfo
    hwinfo
    lshw

    # Miscellaneous
    copyq
    duplicati
    gnomeKeyringPkgs
    gnome3.gnome-tweaks
    gnupg
    openrgb
    peek
    pinentry
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
    # git = gitConfig;
  };

  # File configurations
  home.file = {
    ".config/kitty/kitty.conf" = kittyConfig;
    ".config/neofetch/config.conf" = neofetchConfig;
    ".config/i3/config" = i3Config;
    ".config/rofi/config.rasi" = rofiConfig;
    "modules/bashrc" = {
      source = "/etc/nixos/configs/bashrc";
      target = "${config.home.homeDirectory}/.bashrc";
    };
  };
}
