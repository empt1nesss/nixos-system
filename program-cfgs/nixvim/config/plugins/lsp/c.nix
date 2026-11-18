{ pkgs, ... }:
{
  plugins.lsp.servers.clangd = {
    enable = true;
    cmd = [
      "${pkgs.clang-tools}/bin/clangd"
      "--background-index"
      "--clang-tidy"
      "--header-insertion=never"
    ];
  };

  plugins.conform-nvim.settings = {
    formatters_by_ft.c = [ "clang_format" ];
    formatters_by_ft.cpp = [ "clang_format" ];
    formatters.clang_format.command = "${pkgs.clang-tools}/bin/clang-format";
  };
}
