{
  description = "";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "flake:nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "flake:home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: let
    flakeContext = {
      inherit inputs;
    };
  in {
    darwinConfigurations = {
      persona = import ./darwinConfigurations/persona.nix flakeContext;
    };
    homeConfigurations = {
      potato = import ./homeConfigurations/potato.nix flakeContext;
    };
  };
}
