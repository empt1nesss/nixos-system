{ config, lib, pkgs, ... }:

{
  # Services
  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
  };

  # xdg
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [ "gnome" "gtk" ];
  };
}

