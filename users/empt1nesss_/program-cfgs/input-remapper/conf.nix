{ config, lib, pkgs, ... }:

{
  xdg.configFile."input-remapper-2".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/users/${config.home.username}/program-cfgs/input-remapper/ir-cfg";
}

