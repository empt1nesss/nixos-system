{ pkgs }:

pkgs.vim-full.customize {
  name = "vim";
  vimrcConfig.customRC = ''
    syntax on
    set number
    set tabstop=2
    set shiftwidth=2
    set expandtab
    set mouse=a
    set termguicolors
    set clipboard=unnamedplus
  '';
  vimrcConfig.packages.myPlugins = with pkgs.vimPlugins; {
    start = [
      vim-airline
    ];
    opt = [];
  };
}

