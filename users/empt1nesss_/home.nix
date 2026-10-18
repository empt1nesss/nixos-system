{ config, lib, pkgs, ... }:

let
  programCfgsDir = ./program-cfgs;
  dirContents = builtins.readDir programCfgsDir;
  subDirs = lib.filterAttrs (name: type: type == "directory") dirContents;
  confFiles = lib.mapAttrsToList (name: _: programCfgsDir + "/${name}/conf.nix") subDirs;
  programCfgsImports = builtins.filter builtins.pathExists confFiles;
in
{
  imports =
    [
      ./programs.nix
    ]
    ++ programCfgsImports;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file."Downloads".source = config.lib.file.mkOutOfStoreSymlink "/mnt/win/D/Home/${config.home.username}/Downloads";
  home.file."Documents".source = config.lib.file.mkOutOfStoreSymlink "/mnt/win/D/Home/${config.home.username}/Documents";
  home.file."Music".source = config.lib.file.mkOutOfStoreSymlink "/mnt/win/D/Home/${config.home.username}/Music";
  home.file."Pictures".source = config.lib.file.mkOutOfStoreSymlink "/mnt/win/D/Home/${config.home.username}/Pictures";
  home.file."Videos".source = config.lib.file.mkOutOfStoreSymlink "/mnt/win/D/Home/${config.home.username}/Videos";

  xdg.configFile."autostart".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/users/${config.home.username}/autostart";

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}

