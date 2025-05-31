{
  description = "My humble Nix config!";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:youwen5/zen-browser-flake";
    pyprland.url = "github:hyprland-community/pyprland";

    # wezterm = {
    #   url = "github:wez/wezterm?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      nixVer = "24.11";

      mkHost =
        {
          name,
          role,
          user,
          systemFile,
          homeFile,
        }:
        let
          hostRole = role;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system hostRole;
          };
          modules = [
            ./system/${systemFile}
            {
              programs.hyprland.enable = true;
              programs.river.enable = true;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = import ./home-manager/${homeFile};
              home-manager.extraSpecialArgs = {
                inherit inputs system hostRole;
              };
            }
            { system.stateVersion = nixVer; }
          ];
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost {
          name = "desktop";
          role = "desktop";
          user = "floork";
          systemFile = "desktop.nix";
          homeFile = "personal.nix";
        };

        laptop = mkHost {
          name = "laptop";
          role = "laptop";
          user = "floork";
          systemFile = "laptop.nix";
          homeFile = "personal.nix";
        };

        work = mkHost {
          name = "work";
          role = "work";
          user = "flmr799e";
          systemFile = "work.nix";
          homeFile = "work.nix";
        };
      };
    };
}
