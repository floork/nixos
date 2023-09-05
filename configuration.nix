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
    xkbOptions = "caps:f13";

    desktopManager = { xterm.enable = false; };
    displayManager = { defaultSession = "none+i3"; };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu # application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock # default i3 screen locker
        i3blocks # if you are planning on using i3blocks over i3status
      ];
      # cursor.theme = "./Future-black-cursors/index.theme";/* --> tbd */
    };
  };

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

  services.picom.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.floork = {
    isNormalUser = true;
    description = "floork";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "docker"
      ''
        libvirtd
      ''
    ];
    home = "/home/floork";
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.floork = import ./home.nix;
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

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

  # Enable Fish as the default shell.
  programs.fish.enable = true;

  nix.gc = {
    automatic = true; # Enable automatic garbage collection.
    dates = "weekly"; # Specify the schedule for garbage collection.
    options = "--delete-older-than 5b"; # Delete builds older than 7 days.
  };

  system.autoUpgrade.enable = true;
  system.stateVersion = "23.05";
}
