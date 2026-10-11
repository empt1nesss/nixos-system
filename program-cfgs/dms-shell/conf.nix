{ config, pkgs, ... }:

{
  programs.dms-shell = {
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };
}
