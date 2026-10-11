{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    gcc
    clang
    llvm
    gdb
    cmake
    ninja
    gnumake
    (import ./program-cfgs/vim/pkg.nix { inherit pkgs; })
  ];

  programs.git.enable = true;
  programs.niri.enable = true;
  programs.dms-shell.enable = true;
  programs.dconf.enable = true;
  programs.throne.enable = true;
}

