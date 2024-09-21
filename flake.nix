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
        canvas-bibata = pkgs.stdenv.mkDerivation {
          pname = "canvas-bibata-cursors";
          version = "latest";

          src = pkgs.fetchFromGitHub {
            owner = "localghost385";
            repo = "canvas-bibata";
            rev = "main"; # Pin a specific commit or use a tag
            sha256 = "sha256-Ez8jz/C0xPmffsnH8lZKUz8FFJQBBHYGCBt1AAk+Ug4="; 
          };

          installPhase = ''
            mkdir -p $out/share/icons/canvas-bibata
            cp -r * $out/share/icons/canvas-bibata
          '';

          # Add a post-install script to copy to user's home directory
          postInstall = ''
            if [ -d "$HOME/.local/share/icons" ]; then
              cp -r $out/share/icons/canvas-bibata "$HOME/.local/share/icons/"
              echo test
            else
              mkdir -p "$HOME/.local/share/icons"
              cp -r $out/share/icons/canvas-bibata "$HOME/.local/share/icons/"
              echo testtest
            fi
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
