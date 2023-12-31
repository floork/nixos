{ inputs, config, pkgs, ... }:

{
  # ENV 
  environment = {
    variables = { EDITOR = "nvim"; };
    sessionVariables = rec {
      # Hint Electron apps to use wayland
      NIXOS_OZONE_WL = "1";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };

    shells = with pkgs; [ zsh ];

    pathsToLink = [ "/libexec" ];

    etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text =
        "	bluez_monitor.properties = {\n		[\"bluez5.enable-sbc-xq\"] = true,\n		[\"bluez5.enable-msbc\"] = true,\n		[\"bluez5.enable-hw-volume\"] = true,\n		[\"bluez5.headset-roles\"] = \"[ hsp_hs hsp_ag hfp_hf hfp_ag ]\"\n	}\n";
    };
  };

  # List services that you want to enable:
  services = {
    # OpenSSH daemon
    openssh.enable = true;

    dbus.enable = true;

    xserver = {
      enable = true;
      layout = "us";
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    picom.enable = true;

    logind.extraConfig = "HandleLidSwitch=hibernate";

    fprintd.enable = true;

    flatpak.enable = true;

    gnome.gnome-keyring.enable = true;

    devmon.enable = true;

    gvfs.enable = true;

    udisks2.enable = true;

    udev.extraRules = ''
      SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{UDISKS_PRESENTATION_HIDE}="0"
      SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="vfat", ENV{UDISKS_PRESENTATION_HIDE}="0"
    '';

    ratbagd.enable = true;
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
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  users.users.floork = {
    isNormalUser = true;
    description = "floork";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "pulse"
      "docker"
      ''
        libvirtd
      ''
      "plugdev"
    ];
    home = "/home/floork";
  };
  users.extraGroups.vboxusers.members = [ "floork" ];

  # Window manager
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    waybar.enable = true;
  };

  # Helps enable screen sharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable sound with pipewire
  # sound.enable = true;
  security.rtkit.enable = true;

  # Enable Docker
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    virtualbox = { host.enable = true; };
  };

  # Add additional man pages 
  documentation.dev.enable = true;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
