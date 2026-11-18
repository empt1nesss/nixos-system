{
  extraConfigLuaPre = ''
    -- Disable the legacy directory explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Disable the newer built-in directory explorer
    vim.g.loaded_nvim_dir_plugin = 1
  '';
  plugins.neo-tree = {
    enable = true;
    settings = {
      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];
      add_blank_line_at_top = false;

      event_handlers = [
        {
          event = "neo_tree_window_after_open";
          handler.__raw = ''
            function(args)
              if args.position == "left" or args.position == "right" then
                vim.cmd("horizontal wincmd =")
              end
            end
          '';
        }
        {
          event = "neo_tree_window_after_close";
          handler.__raw = ''
            function(args)
              if args.position == "left" or args.position == "right" then
                vim.cmd("horizontal wincmd =")
              end
            end
          '';
        }
      ];

      filesystem = {
        bind_to_cwd = true;
        hijack_netrw_behavior = "open_current";

        follow_current_file = {
          enabled = true;
        };
      };

      default_component_configs = {
        indent = {
          with_expanders = true;
          expander_collapsed = "󰅂";
          expander_expanded = "󰅀";
          expander_highlight = "NeoTreeExpander";
        };

        git_status = {
          symbols = {
            added = " ";
            conflict = "󰩌 ";
            deleted = "󱂥";
            ignored = " ";
            modified = " ";
            renamed = "󰑕";
            staged = "󰩍";
            unstaged = "";
            untracked = " ";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = "<cmd>Neotree toggle<cr>";
      options = {
        desc = "Open/Close Neotree";
      };
    }
  ];
}
