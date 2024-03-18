{ inputs, system, config, pkgs, ... }:
let
  # Wezterm as flake
  wezterm-custom = inputs.wezterm.packages."${system}".default;

  # Grimblast
  grimblast-custom = inputs.hyprland-contrib.packages.${pkgs.system}.grimblast;
in {
  imports = [ inputs.hyprland.homeManagerModules.default ];

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
    grimblast-custom
    hyprland-protocols
    slurp
    swaybg
    waybar
    waypaper
    wl-clipboard
    wofi
    wttrbar
    xdg-desktop-portal-hyprland
    xwaylandvideobridge

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
    libsForQt5.okular
    libsForQt5.qt5ct
    nixfmt
    nwg-look
    openssl
    openssl.dev
    p7zip
    pavucontrol
    playerctl
    sqlite
    translate-shell
    trash-cli
    xorg.xkill
    zip

    # Desktop Applications
    betterbird
    brave
    chromium
    element-desktop
    gimp
    gnome.gnome-disk-utility
    localsend
    libsForQt5.kruler
    networkmanagerapplet
    obs-studio
    obsidian
    spotify
    texmaker
    # thunderbird # now using betterbird
    tmux
    virt-manager
    warp-terminal
    wezterm-custom
    xfce.thunar
    xfce.tumbler
    yubikey-manager-qt

    # Development
    ## c/c++
    cmake
    neocmakelsp
    meson
    ## go
    go
    gopls
    ## java
    openjdk
    ## js
    nodejs
    nodejs_20
    yarn
    ## lua
    lua
    lua-language-server
    ## nix
    nil
    ## python
    poetry
    pyenv
    python311Packages.pygobject3
    python3
    python311Packages.pip
    ## rust
    rustup
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
    ripgrep # needed for telescope-fzf
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
    gnupg
    peek
    pinentry
    starship
  ];

  fonts.fontconfig.enable = true;

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark =
        "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    size = 38;
    name = "phinger-cursors";
    package = pkgs.phinger-cursors;
  };
}
