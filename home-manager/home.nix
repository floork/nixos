{ inputs, system, config, pkgs, ... }:
let
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

  wezterm-custom = inputs.wezterm.packages."${system}".default;

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
    grim
    slurp
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
    gh
    htop
    neofetch
    pkg-config
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
    emote
    feh
    fprintd
    fuse
    gcc
    git
    graphviz
    gparted
    inxi
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
    sqlite
    translate-shell
    trash-cli
    xorg.xkill

    # Desktop Applications
    chromium
    discord
    element-desktop
    # firefox # moved to floorp for now
    floorp
    gimp
    gnome.gnome-disk-utility
    insync
    libsForQt5.kruler
    networkmanagerapplet
    obsidian
    prismlauncher
    protonmail-bridge
    qbittorrent
    remmina
    spotify
    texmaker
    thunderbird
    tmux
    virt-manager
    wezterm-custom

    kitty


    xfce.thunar
    xfce.tumbler
    yubikey-manager-qt

    # Development
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
    pyenv
    python311Packages.pygobject3
    python3
    python311Packages.pip
    ## sql
    beekeeper-studio
    mysql-workbench
    ## zig
    zig
    ## tools
    ansible
    hugo
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
    gnome3.gnome-tweaks
    gnupg
    peek
    pinentry
    starship

    # Wine
    wineWow64Packages.full
  ];

  fonts.fontconfig.enable = true;

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };
}
