{ inputs, config, pkgs, ... }:

{
  programs.firefox = {
    languagePacks = [ "en-US" ];
    profiles.default = {
      id = 0;
      isDefault = true;
      name = "default";
      settings = {
        "privacy.resistFingerprinting" = true;
        "extensions.autoDisableScopes" = "0";
        "browser.startup.page" = 3;
      };
      search = {
        force = true;
        default = "ddg";
      };
      extensions.packages = with pkgs.firefoxAddons; [
        ublock-origin
        darkreader
      ];
    };
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
    };
  };
}

