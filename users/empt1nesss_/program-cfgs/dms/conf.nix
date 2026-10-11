{ config, lib, pkgs, ... }:

{
  xdg.configFile."DankMaterialShell".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/users/${config.home.username}/program-cfgs/dms/dms-config";
}

