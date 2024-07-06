{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./work/hardware-configuration.nix
    ./configs/networking.nix
    ./configs/packages.nix
    ./configs/base.nix
  ];

  users.users.flmr799e = {
    isNormalUser = true;
    description = "flmr799e";
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
    home = "/home/flmr799e";
  };

  users.extraGroups.vboxusers.members = [ "flmr799e" ];

  users.users.flmr799e.packages = with pkgs; [ ];
}
