{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flatpak.url = "github:gmodena/nix-flatpak";
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  outputs = { self, nixpkgs, catppuccin, flatpak, spicetify, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        flatpak.nixosModules.nix-flatpak
        ./hosts/default/configuration.nix
        catppuccin.nixosModules.catppuccin
        spicetify.nixosModules.default
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
