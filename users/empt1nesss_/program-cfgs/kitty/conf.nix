{ config, pkgs, ... }:

{
  programs.kitty = {
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 12;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      copy_on_select = true;
      window_padding_width = 4;
      background_opacity = "0.9";
      background = "#000000";
      clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
    };
    extraConfig = ''
    '';
  };
}


