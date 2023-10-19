{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking.
  networking.networkmanager.enable = true;

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

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  programs.hyprland = { enable = true; };

  programs.waybar.enable = true;

  services.picom.enable = true;

  services.logind.extraConfig = "HandleLidSwitch=ignore";

  services.fprintd = { enable = true; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.floork = {
    isNormalUser = true;
    description = "floork";
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
    shell = pkgs.zsh;
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.floork = import ./home.nix;
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [ nerdfonts ];

  environment.sessionVariables = rec {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "floork" ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez;

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text =
      "	bluez_monitor.properties = {\n		[\"bluez5.enable-sbc-xq\"] = true,\n		[\"bluez5.enable-msbc\"] = true,\n		[\"bluez5.enable-hw-volume\"] = true,\n		[\"bluez5.headset-roles\"] = \"[ hsp_hs hsp_ag hfp_hf hfp_ag ]\"\n	}\n";
  };

  xdg.portal.enable = true;
  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # kdeconnect
  networking.firewall.allowedTCPPorts = [ 1716 ]; # Adjust as needed
  networking.firewall.allowedUDPPorts = [ 1714 ]; # Adjust as needed

  # enable zsh as the default shell
  programs.zsh.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ntfs", ENV{UDISKS_PRESENTATION_HIDE}="0"
    SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="vfat", ENV{UDISKS_PRESENTATION_HIDE}="0"
  '';

  nix.gc = {
    automatic = true; # Enable the automatic garbage collector
    dates = "03:15"; # When to run the garbage collector
    options = "-d"; # Arguments to pass to nix-collect-garbage
  };

  system.autoUpgrade.enable = true;
  system.stateVersion = "23.05";
}
