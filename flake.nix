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
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ghostty
    ghostty.url = "github:ghostty-org/ghostty";

    # Nix Flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    # Hyprland window manager 
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
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
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

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
      nix-flatpak,
      hyprland,
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

      nixVer = "23.11";
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
            hyprland.nixosModules.default
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
            nix-flatpak.nixosModules.nix-flatpak
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
            hyprland.nixosModules.default
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
            nix-flatpak.nixosModules.nix-flatpak
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
            hyprland.nixosModules.default
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
            nix-flatpak.nixosModules.nix-flatpak
            { system.stateVersion = nixVer; }
          ];
        };
      };
    };
}
