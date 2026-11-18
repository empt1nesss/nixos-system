{
  plugins.gitsigns = {
    enable = true;
    settings = {
      preview_config = {
        border = "rounded";
      };
      signcolumn = true;
      signs_staged_enable = false;
      # Both staged and unstaged changes use the same single-cell line glyph.
      signs = {
        add.text = "┃ ";
        change.text = " ┃";
        untracked.text = "┆ ";
        delete.text = " ";
        topdelete.text = "󱂥 ";
        changedelete.text = "󱂧 ";
      };
      word_diff = false;
    };
  };

  extraConfigLua = ''
    local function apply_gitsigns_colors()
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a6da95" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#eed49f" })
      vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#eed49f" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ed8796" })
      vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#ed8796" })
      vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#a6da95" })
      -- Staged signs have their own, more subdued highlight group.
      for _, suffix in ipairs({"Add", "Change", "Delete", "Topdelete", "Changedelete"}) do
        vim.api.nvim_set_hl(0, "GitSignsStaged" .. suffix, { fg = "#939ab7" })
      end
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_gitsigns_colors })
    apply_gitsigns_colors()
  '';

  keymaps = [
    {
      mode = "n";
      key = "]h";
      action = "<cmd>Gitsigns nav_hunk next<cr>";
      options = {
        desc = "Next Git hunk";
      };
    }
    {
      mode = "n";
      key = "[h";
      action = "<cmd>Gitsigns nav_hunk prev<cr>";
      options = {
        desc = "Previous Git hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>ghp";
      action = "<cmd>Gitsigns preview_hunk_inline<cr>";
      options = {
        desc = "Preview Git hunk inline";
      };
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Gitsigns blame_line<cr>";
      options = {
        desc = "Blame Git line";
      };
    }
    {
      mode = "n";
      key = "<leader>gW";
      action = "<cmd>Gitsigns toggle_word_diff<cr>";
      options = {
        desc = "Toggle Git word diff";
      };
    }
  ];
}
