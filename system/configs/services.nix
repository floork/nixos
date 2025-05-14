{
  ...
}:
{
  services = {
    # clamav = {
    #   daemon.enable = true;
    #   updater.enable = true;
    #   scanner = {
    #     enable = true;
    #     interval = "hourly";
    #   };
    #   fangfrisch = {
    #     enable = true;
    #     interval = "hourly";
    #   };
    # };

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

    avahi.enable = true;
    avahi.nssmdns4 = true;
    avahi.openFirewall = true; # Opens necessary ports in the NixOS firewall [1, 11]
  };
}
