{ pkgs, custom, ... }:

with pkgs;
[
  custom.zenBrowser
  custom.swww

  chromium
  element-desktop
  ghostty
  gimp
  legcord
  localsend
  libsForQt5.kruler
  networkmanagerapplet
  obs-studio
  obsidian
  spotify
  thunderbird
  tmux
  xfce.thunar
  xfce.tumbler
]
