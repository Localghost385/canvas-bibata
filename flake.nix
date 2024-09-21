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
          src = pkgs.fetchFromGitHub {
            owner = "localghost385";
            repo = "canvas-bibata";
            rev = "main"; # Pin a specific commit or use a tag
            sha256 = "sha256-Ez8jz/C0xPmffsnH8lZKUz8FFJQBBHYGCBt1AAk+Ug4="; # Replace with the actual hash after fetching
          };

          # Install the theme to the standard X cursor theme directory
          installPhase = ''
            rm -rf /usr/share/icons/canvas-bibata
            mkdir -p /usr/share/icons/canvas-bibata
            cp -r * /usr/share/icons/canvas-bibata
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
