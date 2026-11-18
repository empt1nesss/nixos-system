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

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
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

