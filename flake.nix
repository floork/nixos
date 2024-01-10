{
  description = "My humble Nix config!";

  nixConfig = {
    # manage flakes 
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland window manager 
    hyprland.url = "github:hyprwm/Hyprland";
    # Community scripts and utilities for Hypr projects
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wezterm
    wezterm.url = "/etc/nixos/own-flakes/wezterm/nix";
    wezterm.inputs = { nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;

      # wezterm
      weztermFlake = import inputs.own-flakes.wezterm;

    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            ./system/desktop.nix
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.floork = import ./home-manager/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }

            {
              environment.systemPackages =
                [ weztermFlake.packages.${system}.wezterm ];
            }
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            ./system/laptop.nix
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.floork = import ./home-manager/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }

            {
              environment.systemPackages =
                [ weztermFlake.packages.${system}.wezterm ];
            }
          ];
        };
      };
    };
}
