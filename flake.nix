{
  description = "My humble Nix config!";

  nixConfig = {
    # manage flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Community scripts and utilities for Hypr projects
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprlock
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hypridle
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:youwen5/zen-browser-flake";

    pyprland.url = "github:hyprland-community/pyprland";

    # WezTerm package
    # wezterm = {
    #   url = "github:wez/wezterm?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      # hyprland,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      lib = nixpkgs.lib;

      nixVer = "24.11";
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            ./system/desktop.nix
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.floork = import ./home-manager/personal.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs system;
              };
            }
            { system.stateVersion = nixVer; }
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            ./system/laptop.nix
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.floork = import ./home-manager/personal.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs system;
              };
            }
            { system.stateVersion = nixVer; }
          ];
        };
        work = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            ./system/work.nix
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.flmr799e = import ./home-manager/work.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs system;
              };
            }
            { system.stateVersion = nixVer; }
          ];
        };
      };
    };
}
