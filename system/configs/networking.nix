{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [
        80
        443
        53317
      ]; # 53317 is for LocalSend
      allowedUDPPortRanges = [
        {
          from = 4000;
          to = 4007;
        }
        {
          from = 53315;
          to = 53318;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
    nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };
}
