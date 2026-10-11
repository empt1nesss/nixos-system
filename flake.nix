{
  description = "NixOS System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oh-my-bash = {
      url = "github:ohmybash/oh-my-bash";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-doom-emacs-unstraightened, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
	        ./configuration.nix
	        home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.empt1nesss_ = ./users/empt1nesss_/home.nix;
	            backupFileExtension = "bkp";
            };
            nixpkgs.overlays = [
              (final: prev: {
                firefoxAddons = nur.legacyPackages.${final.stdenv.hostPlatform.system}.repos.rycee.firefox-addons;
              })
            ];
          }
	      ];
      };
    };
  };
}

