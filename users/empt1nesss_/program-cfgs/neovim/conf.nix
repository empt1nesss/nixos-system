{ config, pkgs, ... }:

{
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/users/${config.home.username}/program-cfgs/neovim/nvim-config";
}

