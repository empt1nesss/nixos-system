{ config, pkgs, ... }:

{
  users.users.empt1nesss_ = {
    isNormalUser = true;
    extraGroups = [ "wheel" "netdev" "video" "input" "openrazer" ];
  };
}

