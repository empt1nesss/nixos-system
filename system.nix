{ config, lib, pkgs, ... }:

{
  # Network and time
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  time.timeZone = "Europe/Moscow";

  # Environment
  environment.variables = {
    EDITOR = "vim";
  };

  environment.etc."inputrc".text = ''
    "\e[A": history-search-backward
    "\e[B": history-search-forward
    "\eOA": history-search-backward
    "\eOB": history-search-forward
  '';

  qt = {
    enable = true;
    style = "adwaita-dark";
  };
}

