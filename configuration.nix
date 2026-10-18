{ config, lib, pkgs, ... }:

let
  programCfgsDir = ./program-cfgs;
  dirContents = builtins.readDir programCfgsDir;
  subDirs = lib.filterAttrs (name: type: type == "directory") dirContents;
  confFiles = lib.mapAttrsToList (name: _: programCfgsDir + "/${name}/conf.nix") subDirs;
  programCfgsImports = builtins.filter builtins.pathExists confFiles;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./system.nix
      ./services.nix
      ./programs.nix
      ./users/empt1nesss_/system.nix
    ]
    ++ programCfgsImports;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enble unfree packges
  nixpkgs.config.allowUnfree = true;

  # Boot and kernel
  boot.loader = {
    timeout = null;
    systemd-boot.enable = false;
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "nodev";
    grub.configurationLimit = 5;
    grub.useOSProber = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Mount another disks
  fileSystems = {
    "/mnt/win/C" = {
      device = "/dev/disk/by-uuid/2E5C8BC85C8B8973";
      fsType = "ntfs";
      options = [
        "defaults"
        "nofail"
        "uid=1000"
        "gid=100"
        "umask=022"
      ];
      noCheck = true;
    };
    "/mnt/win/D" = {
      device = "/dev/disk/by-uuid/4090C30490C30000";
      fsType = "ntfs";
      options = [
        "defaults"
        "nofail"
        "uid=1000"
        "gid=100"
        "umask=022"
      ];
      noCheck = true;
    };
    "/mnt/win/E" = {
      device = "/dev/disk/by-uuid/3CD6D286D6D24036";
      fsType = "ntfs";
      options = [
        "defaults"
        "nofail"
        "uid=1000"
        "gid=100"
        "umask=022"
      ];
      noCheck = true;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

