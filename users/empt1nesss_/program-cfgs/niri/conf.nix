{ config, lib, pkgs, ... }:

{
  xdg.configFile."niri".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/users/${config.home.username}/program-cfgs/niri/niri-config";
}

