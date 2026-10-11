{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    jq

    # networking tools
    nmap

    # misc
    file
    which
    tree
    gnutar
    gnupg
    wl-clipboard
    fastfetch
    xwayland-satellite

    # monitoring
    btop
    iotop
    iftop

    # system tools
    home-manager
    lm_sensors
    ethtool
    pciutils
    usbutils

    # fonts
    nerd-fonts.fira-code

    # icons
    bibata-cursors

    # work
    blender

    # social
    telegram-desktop
    discord

    # development
    neovim
    llvmPackages.clang-tools
  ];

  programs.bash.enable = true;
  programs.doom-emacs.enable = true;
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.kitty.enable = true;
}

