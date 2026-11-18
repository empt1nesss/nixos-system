{
  lib,
  pkgs,
  ...
}:
{
  config = {
    extraConfigLua = ''
      vim.api.nvim_create_user_command("Format", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end, { desc = "Format current buffer on demand" })
    '';
    plugins.conform-nvim = {
      enable = true;
      settings = {
        # Formatters can still be invoked explicitly with :Format.
        # Never run them as a side effect of writing a buffer.
        format_on_save = null;
        format_after_save = null;
        notify_on_error = true;
        formatters_by_ft = {
          html = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          css = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          lua = [ "stylua" ];
          markdown = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          bicep = [ "bicep" ];
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          json = [ "jq" ];
          "_" = [ "trim_whitespace" ];
        };

        formatters = {
          alejandra = {
            command = "${lib.getExe pkgs.alejandra}";
          };
          jq = {
            command = "${lib.getExe pkgs.jq}";
          };
          shellcheck = {
            command = "${lib.getExe pkgs.shellcheck}";
          };
          shfmt = {
            command = "${lib.getExe pkgs.shfmt}";
          };
          shellharden = {
            command = "${lib.getExe pkgs.shellharden}";
          };
          yamlfmt = {
           command = "${lib.getExe pkgs.yamlfmt}";
          };
        };
      };
    };
  };
}
