{
  plugins = {
    indent-blankline = {
      enable = true;
      settings.exclude.filetypes = [
        "dashboard"
        "snacks_dashboard"
        "neo-tree"
        "help"
        "TelescopePrompt"
        "Trouble"
        "toggleterm"
      ];
      settings.scope.enabled = false;
    };
  };
}
