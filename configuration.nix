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
  };
};

services.picom.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.floork = {
    isNormalUser = true;
    description = "floork";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
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

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    git
    vim
    wget
    starship
    fish
    curl
    exa
    neofetch
    util-linux
    htop
    gh
    rofi
    xfce.thunar
    betterlockscreen
    dunst
    libnotify
    vscode
    killall
    bluez
    bluez-tools
    blueman
    pipewire
  ];

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    meslo-lg
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

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
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
};

  # services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable Fish as the default shell.
  programs.fish.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable.

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # services.home-manager-auto-upgrade = true;
  system.autoUpgrade.enable = true;
  system.stateVersion = "23.05";
}
