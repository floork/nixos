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

in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  # Info about user and path it manages
  home.username = "floork";
  home.homeDirectory = "/home/floork";
 
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces breaking changes.
  home.stateVersion = "23.05";
  
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
    alsa-utils
    bitwarden
    bitwarden-cli
    bluez
    bluez-tools
    blueman
    docker
    emote
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
    nixfmt
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
    element-desktop
    flameshot
    gimp
    insync
    kitty
    libsForQt5.kruler
    libreoffice
    lutris
    networkmanagerapplet
    obs-studio
    obsidian
    prismlauncher
    protonmail-bridge
    qbittorrent
    remmina
    slurp
    spotify
    thunderbird
    webcord
    whatsapp-for-linux
    xfce.thunar
    yubikey-manager-qt
    webcord

    # Development
    beekeeper-studio
    cmake
    libratbag
    lua
    lua-language-server
    meson
    mysql-workbench
    nodejs
    nodejs_20
    openjdk
    python311Packages.pygobject3
    python3
    python311Packages.pip
    virt-manager
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
    neovim
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
 ];

  fonts.fontconfig.enable = true;

}
