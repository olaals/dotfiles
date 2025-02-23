{
  description = "My NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";

    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Keep in sync with nixpkgs
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "aarch64-linux";
    username = "quack";  # Your actual username
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix # Your main NixOS configuration
        home-manager.nixosModules.home-manager # Enables Home Manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home.nix; # Load home.nix correctly
        }
      ];
    };
  };
}

