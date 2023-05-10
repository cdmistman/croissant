{
  description = "A very basic flake";

  inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.devenv.flakeModule
    ];

    systems = [
      "aarch64-darwin"
    ];

    perSystem = { pkgs, ... }: {
      devenv.shells.default = {
        languages.javascript = {
          enable = true;
          package = pkgs.bun;
        };
      };
    };
  };
}
