{ pkgs, ... }:
{
  plugins.lsp.servers.neocmake.enable = true;
  plugins.conform-nvim.settings = {
    formatters_by_ft.cmake = [ "cmake_format" ];
    formatters.cmake_format.command = "${pkgs.cmake-format}/bin/cmake-format";
  };
}
