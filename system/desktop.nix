{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./desktop/hardware-configuration.nix
    ./configs/networking.nix
    ./configs/packages.nix
    ./configs/base.nix
  ];

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
      "plugdev"
      ''
        libvirtd
      ''
    ];
    home = "/home/floork";
  };
  users.extraGroups.vboxusers.members = [ "floork" ];

  users.users.floork.packages = with pkgs; [
    # System Utilities
    solaar

    # Desktop Applications
    bottles
    lutris
    piper
    prismlauncher
    protonmail-bridge
    qbittorrent

    # Development
    ## gamedev
    libratbag

    # Miscellanious
    openrgb
    duplicati

    # Wine
    wineWow64Packages.full

    # keyboard
    wally-cli

    # wezterm
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  boot.plymouth.enable = false;
}
