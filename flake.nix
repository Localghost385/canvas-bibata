{
  description = "Flake to install canvas-bibata X cursor theme";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = let
      # Import the nixpkgs set.
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in {
      # Define a package that installs the canvas-bibata cursor theme
      xcursorTheme = pkgs.stdenv.mkDerivation {
        pname = "canvas-bibata-cursors";
        version = "latest";

        # Fetch the theme from the GitHub repository
        src = pkgs.fetchFromGitHub {
          owner = "localghost385";
          repo = "canvas-bibata";
          rev = "main"; # You can pin a specific commit if needed
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with the actual hash after fetching
        };

        installPhase = ''
          mkdir -p $out/share/icons
          cp -r * $out/share/icons/canvas-bibata
        '';

        meta = with pkgs.lib; {
          description = "canvas-bibata X cursor theme";
          license = licenses.mit; # License based on the repo
          platforms = platforms.linux;
        };
      };
    };
  };
}
