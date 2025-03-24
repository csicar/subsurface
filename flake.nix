{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            subsurface = prev.subsurface.overrideAttrs (old: {
              src = ./.;
              buildInputs = (old.buildInputs or []) ++ [ pkgs.qt5.full pkgs.libdivecomputer ];
              nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.autoreconfHook ];
            });
          })
        ];
      };
    in {
      packages.${system}.default = pkgs.subsurface;
    };
}
