{ inputs, config, pkgs, ... }:
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

in
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  # Info about user and path it manages
  home.username = "floork";
  home.homeDirectory = "/home/floork";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces breaking changes.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CURRENT_DESKTOP = "Sway";
  };

  # User packages
  home.packages = with pkgs; [
    # hyprland stuff
    dunst
    swaybg
    swaylock
    waybar
    waypaper
    wl-clipboard
    wofi

    # theme
    juno-theme
    gnome.adwaita-icon-theme

    # Terminal Utilities
    brightnessctl
    curl
    dig
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
    xorg.xev
    xorg.xhost
    zsh-autosuggestions
    zsh-syntax-highlighting

    # System Utilities
    alsa-utils
    bitwarden
    bitwarden-cli
    bluez
    bluez-tools
    blueman
    docker
    emacsPackages.adwaita-dark-theme
    emote
    feh
    fprintd
    fuse
    gcc
    git
    graphviz
    gparted
    inxi
    kdeconnect
    killall
    libiconv
    libnotify
    libsForQt5.qt5ct
    nixfmt
    nwg-look
    openssl
    openssl.dev
    p7zip
    pavucontrol
    pipewire
    playerctl
    solaar
    sqlite
    translate-shell
    trash-cli
    xorg.xkill

    # Desktop Applications
    bottles
    brave
    chromium
    discord
    element-desktop
    flameshot
    gimp
    gnome.gnome-disk-utility
    grim
    insync
    kitty
    libsForQt5.kruler
    libreoffice
    lutris
    networkmanagerapplet
    obsidian
    piper
    prismlauncher
    protonmail-bridge
    qbittorrent
    remmina
    slurp
    spotify
    texmaker
    thunderbird
    tmux
    virt-manager
    whatsapp-for-linux
    xfce.thunar
    xfce.tumbler
    yubikey-manager-qt

    # Development
    ## automation
    ansible
    ## c/c++
    cmake
    meson
    ## gamedev
    libratbag
    ## go
    go
    ## java
    openjdk
    ## js
    nodejs
    nodejs_20
    yarn
    ## lua
    lua
    lua-language-server
    ## python
    poetry
    python311Packages.pygobject3
    python3
    python311Packages.pip
    ## sql
    beekeeper-studio
    mysql-workbench
    ## editor
    neovim
    vscode

    # NeoVim
    deno
    fd
    fzf
    gnumake
    grip
    lazygit
    luajitPackages.lua-lsp
    luajitPackages.luarocks-nix
    nodePackages.eslint
    nodePackages.prettier
    pandoc
    python311Packages.pip
    ripgrep
    shfmt
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
    clipman
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

    # Wine
    wineWow64Packages.full
  ];

  fonts.fontconfig.enable = true;

}
