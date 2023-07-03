{ config, pkgs, ... }:

{
  imports =
    [
      # Include the hardware configuration.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "myhostname";

  # Set the system language to English (USA).
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    enable = true;
    extraLocaleSettings = ''
      LC_TIME="en_US.UTF-8"
    '';
  };

  # Set the keyboard layout to German.
  console = {
    keyMap = "de";
    font = "Lat2-Terminus16";
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Set up user accounts.
  users.users = {
    floork = {
      isNormalUser = true;
      uid = 1000;
      home = "/home/floork";
      description = "Floork User";
      extraGroups = [ "wheel" "networkmanager" ];
      password = "mypassword";  # Replace with the actual password.
    };
  };

  # Enable sudo for users in the wheel group.
  security.sudo.wheelNeedsPassword = false;
  
  # Additional system configuration options go here.

  # Example: Install additional packages.
  environment.systemPackages = with pkgs; [
    # List additional packages here
    nano
    htop
    ];
}
