{
  plugins.mini = {
    enable = true;

    modules = {
      indentscope = {
        symbol = "│";
        options.try_as_border = true;
      };
      surround = { };
    };
  };

  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "dashboard"
        "snacks_dashboard"
        "neo-tree"
        "help"
        "TelescopePrompt"
        "Trouble"
        "toggleterm"
      ];
      callback.__raw = ''
        function(args)
          vim.b[args.buf].miniindentscope_disable = true
        end
      '';
    }
  ];
}
