{
  inputs,
  system,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./home.nix ];

  # Info about user and path it manages
  home.username = "floork";
  home.homeDirectory = "/home/floork";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces breaking changes.
  home.stateVersion = "23.11";
}
