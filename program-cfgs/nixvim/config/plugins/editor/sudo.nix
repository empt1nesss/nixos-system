{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.vim-suda
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>W";
      action = "<cmd>SudaWrite<CR>";
      options.desc = "Save file as root";
    }
  ];
}

