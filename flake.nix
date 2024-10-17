{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nmattia/naersk";
      rust-overlay = { 
        url = "github:oxalica/rust-overlay";
      };
  };

  outputs = { self, nixpkgs, utils, naersk, rust-overlay, ...}:
  utils.lib.eachDefaultSystem (system: let
    overlays = [(import rust-overlay)];

    pkgs = import nixpkgs { inherit system overlays;};

      # # Get a specific rust version
      # mozilla = pkgs.callPackage (mozillapkgs + "/package-set.nix") {};
      # rust = (mozilla.rustChannelOf {
      #   date = "2020-12-23";
      #   channel = "nightly";
      #   sha256 = "LbKHsCOFXWpg/SEyACfzZuWjKbkXdH6EJKOPSGoO01E="; # set zeros after modifying channel or date
      # }).rust;
      # rust-src = (mozilla.rustChannelOf {
      #   date = "2020-12-23";
      #   channel = "nightly";
      #   sha256 = "LbKHsCOFXWpg/SEyACfzZuWjKbkXdH6EJKOPSGoO01E="; # set zeros after modifying channel or date
      # }).rust-src;

    in rec {
      # packages.my-project = naersk-lib.buildPackage {
      #   pname = "dijo";
      #   version = "0.2.7";
      #   root = ./.;
      # };
      # defaultPackage = packages.my-project;
      # apps.my-project = utils.lib.mkApp {
      #   drv = packages.my-project;
      # };
      # defaultApp = apps.my-project;
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.rust-analyzer
          pkgs.cargo
          pkgs.openssl
          pkgs.ncurses
        ];
        # shellHook = ''
        #   export RUST_SRC_PATH="${rust-src}/lib/rustlib/src/rust/library"
        # '';
      };
    });
  }
