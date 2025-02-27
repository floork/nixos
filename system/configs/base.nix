{
  inputs,
  config,
  pkgs,
  ...
}:

{
  # ENV
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

  # List services that you want to enable:
  services = {
    # OpenSSH daemon
    openssh.enable = true;

    dbus.enable = true;

    displayManager = {
      ly.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    picom.enable = true;

    logind.extraConfig = "HandleLidSwitch=hibernate";

    gnome.gnome-keyring.enable = true;

    devmon.enable = true;

    gvfs.enable = true;

    udisks2.enable = true;

    udev.extraRules = ''
      SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{UDISKS_PRESENTATION_HIDE}="0"
      SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="vfat", ENV{UDISKS_PRESENTATION_HIDE}="0"
    '';

    printing.enable = true;
    ratbagd.enable = true;

    flatpak = {
      enable = true;
      # remotes = [{
      #   name = "flathub-beta";
      #   location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      # }]; # Uncomment to enable flathub-beta
      packages = [
        "com.discordapp.Discord"
        "com.mojang.Minecraft"
        "com.obsproject.Studio"
        "com.obsproject.Studio.Plugin.BackgroundRemoval"
        "org.libreoffice.LibreOffice"
        "io.qt.Designer"
      ];
      update.onActivation = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options fuse v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  hardware = {
    # pulseaudio = {
    #   enable = true;
    #   support32Bit = true;
    #   package = pkgs.pulseaudioFull;
    # };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    keyboard = {
      zsa = {
        enable = true;
      };
    };
  };

  security = {
    pam = {
      services = {
        hyprlock = {
          text = ''
            auth include login
          '';
        };
        login.enableGnomeKeyring = true;
      };
    };
    rtkit.enable = true;
  };

  # Window manager
  programs = {
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Add additional man pages
  documentation.dev.enable = true;

  system.activationScripts = {
    binbash = {
      deps = [ "binsh" ];
      text = ''
        if ! [ -e /bin/bash ]; then
          ln -s /bin/sh /bin/bash
        fi
        if ! [ -e /bin/zsh ]; then
          ln -s /bin/sh /bin/zsh
        fi
        if [ -e "/usr/bin/env" ] && [ ! -e "/bin/env" ]; then
          ln -s /usr/bin/env /bin/env
        fi
      '';
    };
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
