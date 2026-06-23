{
  description = "My NixOS system configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    baseModule = {
      imports = [
        home-manager.nixosModules.default
      ];
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
    };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      "gy8" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          baseModule
          ./hosts/gy8
        ];
      };
      "gy7" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          baseModule
          ./hosts/gy7
        ];
      };
    };
  };
}
