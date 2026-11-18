{
  # Bytecode cache only; heavy plugins still need a startuptime profile.
  extraConfigLuaPre = ''
    if vim.loader and vim.loader.enable then
      vim.loader.enable()
    end
  '';
}
