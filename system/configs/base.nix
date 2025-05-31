{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./services.nix
    ./environment.nix
  ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
      # Add this to specify which portal to use for what
      config = {
        common = {
          default = [
            "wlr"
            "gtk"
          ];
        };
        wlr = {
          default = [
            "wlr"
            "gtk"
          ];
        };
      };
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

    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
      disabledDefaultBackends = [ "escl" ];
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
    apparmor = {
      enable = true;
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
