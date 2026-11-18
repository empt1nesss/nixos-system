{ lib, pkgs, ... }:
{
  plugins.lsp.servers.pyright.enable = true;
  plugins.conform-nvim.settings = {
    formatters_by_ft.python = [ "black" "isort" ];
    formatters.black.command = lib.getExe pkgs.black;
    formatters.isort.command = lib.getExe pkgs.isort;
  };
}
