{ inputs, config, pkgs, ... }:

{
  imports =
    [
      inputs.nix-doom-emacs-unstraightened.hmModule
    ];

  programs.doom-emacs = {
    doomDir = ./doom-config;
  };
}

