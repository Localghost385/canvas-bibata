{
  description = "Flake to install canvas-bibata X cursor theme";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in
      {
        # Define the package for the canvas-bibata X cursor theme
        canvas-bibata = pkgs.stdenv.mkDerivation {
          pname = "canvas-bibata-cursors";
          version = "latest";

          # Fetch the theme from the GitHub repository
          src = fetchFromGitHub {
            owner = "Silicasandwhich";
            repo = "Bibata_Cursor_Translucent";
            rev = "v${version}";
            sha256 = "sha256-RroynJfdFpu+Wl9iw9NrAc9wNZsSxWI+heJXUTwEe7s=";
          };

          # Install the theme to the standard X cursor theme directory
          installPhase = ''
            install -dm 0755 $out/share/icons
            cp -pr Bibata_* $out/share/icons/
          '';

          meta = with pkgs.lib; {
            description = "Canvas Bibata X cursor theme";
            license = licenses.mit;
            platforms = platforms.linux;
            maintainers = [ maintainers.localghost385 ];
          };
        };
      };
  };
}
