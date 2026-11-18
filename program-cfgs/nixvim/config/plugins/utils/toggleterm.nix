_: {
  plugins.toggleterm = {
    enable = true;
    settings = {
      direction = "horizontal";
      size = 14;
      persist_size = true;
      start_in_insert = true;
      close_on_exit = true;
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>t";
      action = "<cmd>ToggleTerm direction=horizontal<cr>";
      options = {
        desc = "Toggle bottom terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>tn";
      action = "<cmd>TermNew direction=horizontal<cr>";
      options.desc = "New bottom terminal";
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = "<cmd>TermSelect<cr>";
      options.desc = "Select terminal";
    }
    {
      mode = "n";
      key = "<leader>t1";
      action = "<cmd>1ToggleTerm direction=horizontal<cr>";
      options.desc = "Toggle terminal 1";
    }
    {
      mode = "n";
      key = "<leader>t2";
      action = "<cmd>2ToggleTerm direction=horizontal<cr>";
      options.desc = "Toggle terminal 2";
    }
    {
      mode = "n";
      key = "<leader>t3";
      action = "<cmd>3ToggleTerm direction=horizontal<cr>";
      options.desc = "Toggle terminal 3";
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options = {
        desc = "Exit Terminal Mode";
      };
    }
  ];
}
