{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    my-home = {
      url = "github:steav005/home-config";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, nur, deploy-rs
    , home-manager, my-home, ... }@inputs:
    let
      lib = nixpkgs-stable.lib;
      machines = {
        "index" = {
          hostname = "index";
          address = "10.4.0.15";
          arch = "aarch64-linux";
        };
      };
    in {
      nixosConfigurations = lib.mapAttrs (hostname: info:
        lib.nixosSystem rec {
          system = info.arch;

          modules = [
            {
              nixpkgs.overlays = [
                (self: super: {
                  unstable = import "${nixpkgs-unstable}" {
                    inherit system;
                    config = super.config;
                  };
                  stable = import "${nixpkgs-stable}" {
                    inherit system;
                    config = super.config;
                  };
                })
                nur.overlay
              ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "deletable-home-manager-link";
            }
            { networking.hostName = hostname; }
            (./machines + "/${hostname}.nix")
          ];
          specialArgs = {
            inherit inputs;
            inherit nur;
            inherit info;
            inherit home-manager;
          };

        }) machines;

      deploy.nodes = lib.mapAttrs (hostname: info: {
        hostname = info.address;
        fastConnection = false;
        profiles = {
          system = {
            sshUser = "admin";
            path = deploy-rs.lib.${info.arch}.activate.nixos
              self.nixosConfigurations."${hostname}";
            user = "root";
          };
        };
      }) machines;
    };
}
