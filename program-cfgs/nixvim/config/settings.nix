{ pkgs, ... }:
{
  config = {
    extraConfigLuaPre =
      # lua
      ''
        vim.fn.sign_define("diagnosticsignerror", { text = " ", texthl = "diagnosticerror", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignwarn", { text = " ", texthl = "diagnosticwarn", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignhint", { text = "󰌵", texthl = "diagnostichint", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsigninfo", { text = " ", texthl = "diagnosticinfo", linehl = "", numhl = "" })
      '';
    extraConfigLua =
      ''
        vim.opt.incsearch = true
        vim.opt.hlsearch = true
        vim.opt.shortmess:remove("S")
        do
          local function insert_at_selection(at_end)
            local anchor = vim.fn.getpos("v")
            local cursor = vim.fn.getpos(".")

            local forward =
              cursor[2] > anchor[2]
              or (
                cursor[2] == anchor[2]
                and cursor[3] >= anchor[3]
              )

            if at_end then
              -- Move to the right/bottom end of the selection.
              return forward and "<Esc>a" or "o<Esc>a"
            end

            -- Move to the left/top start of the selection.
            return forward and "o<Esc>i" or "<Esc>i"
          end

          vim.keymap.set("x", "i", function()
            return insert_at_selection(false)
          end, {
            expr = true,
            desc = "Insert before Visual selection",
          })

          vim.keymap.set("x", "a", function()
            return insert_at_selection(true)
          end, {
            expr = true,
            desc = "Append after Visual selection",
          })
        end
      '';

    clipboard = {
      providers.wl-copy.enable = pkgs.stdenv.hostPlatform.isLinux;
    };

    opts = {
      # Show line numbers
      number = true;

      # Don't show relative line numbers
      relativenumber = false;

      # Use the system clipboard
      clipboard = "unnamedplus";

      # Number of spaces that represent a <TAB>
      tabstop = 2;
      softtabstop = 2;

      # Show tabline always
      showtabline = 2;

      # Use spaces instead of tabs
      expandtab = true;

      # Enable smart indentation
      smartindent = true;

      # Number of spaces to use for each step of (auto)indent
      shiftwidth = 2;

      # Enable break indent
      breakindent = true;

      # Highlight the screen line of the cursor
      cursorline = true;

      # Minimum number of screen lines to keep above and below the cursor
      scrolloff = 8;

      # Enable mouse support
      mouse = "a";

      # Set folding method to manual
      foldmethod = "manual";

      # Disable folding by default
      foldenable = false;

      # Wrap long lines at a character in 'breakat'
      linebreak = true;

      # Disable spell checking
      spell = false;

      # Disable swap file creation
      swapfile = false;

      # Time in milliseconds to wait for a mapped sequence to complete
      timeoutlen = 300;

      # Enable 24-bit RGB color in the TUI
      termguicolors = true;

      # Don't show mode in the command line
      showmode = false;

      # Improve change alignment in native diff views
      diffopt = "internal,filler,closeoff,algorithm:histogram,indent-heuristic,linematch:60";

      # Open new split below the current window
      splitbelow = true;

      # Keep the screen when splitting
      splitkeep = "screen";

      # Open new split to the right of the current window
      splitright = true;

      # Hide command line unless needed
      cmdheight = 0;

      # Remove EOB
      fillchars = {
        eob = " ";
      };
    };
  };
}
