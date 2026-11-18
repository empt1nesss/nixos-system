{ lib, pkgs, ... }:
{
  # Keep Snacks for its project picker, but don't render its dashboard.
  plugins.snacks = {
    enable = true;
    settings = {
      dashboard.enabled = lib.mkForce false;
      picker.enabled = true;
    };
  };
  # Use exactly the dashboard engine from the old LazyVim configuration.
  # Persistence isn't a NixVim module here, so install it as a regular Vim plugin.
  extraPlugins = [ pkgs.vimPlugins.persistence-nvim ];
  extraConfigLua = ''
    require("persistence").setup()
  '';
  plugins.dashboard = {
    enable = true;
    settings = {
      theme = "doom";
      hide.statusline = false;
      config = {
        header =
          (lib.replicate 6 "")
          ++ (lib.splitString "\n" (builtins.readFile ./dashboard-logo.txt))
          ++ [
            ""
            ""
          ];
        vertical_center = true;
        footer = [ "" ];
        center = [
          {
            action = "ene | startinsert";
            desc = " New File";
            icon = " ";
            key = "n";
          }
          {
            action = "Telescope find_files";
            desc = " Find File";
            icon = " ";
            key = "f";
          }
          {
            action = "Telescope oldfiles";
            desc = " Recent Files";
            icon = " ";
            key = "r";
          }
          {
            action = "lua Snacks.picker.projects()";
            desc = " Projects";
            icon = " ";
            key = "p";
          }
          {
            action = "lua require('persistence').load()";
            desc = " Restore Session";
            icon = " ";
            key = "s";
          }
          {
            action = "lua require('telescope.builtin').find_files({ cwd = '/etc/nixos/program-cfgs/nixvim', hidden = true })";
            desc = " Config";
            icon = " ";
            key = "c";
          }
          {
            action = "qa";
            desc = " Quit";
            icon = " ";
            key = "q";
          }
        ];
      };
    };
  };
}
