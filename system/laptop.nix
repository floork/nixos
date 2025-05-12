{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./laptop/hardware-configuration.nix
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
      ''
        libvirtd
      ''
      "plugdev"
    ];
    home = "/home/floork";
  };

  users.extraGroups.vboxusers.members = [ "floork" ];
}
