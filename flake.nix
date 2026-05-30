{
  description = "My NixOS system configuration.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    baseModule = {
      imports = [
        home-manager.nixosModules.default
      ];
      nixpkgs.overlays = [
        (final: _prev: {
          # (e.g. pkgs.unstable.neovim)
          unstable = import nixpkgs-unstable { inherit system; };
        })
      ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      "gyik-hp" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          baseModule
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
