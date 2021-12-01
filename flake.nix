{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    my-flakes.url = "github:steav005/flakes";
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-unstable, nur, my-flakes
    , deploy-rs, home-manager, agenix, ... }@inputs:
    let
      lib = nixpkgs.lib;
      machines = {
        "neesama" = {
          hostname = "neesama";
          address = "10.0.0.1";
          arch = "x86_64-linux";
        };
        "last-order" = {
          hostname = "last-order";
          address = "10.0.0.2";
          arch = "x86_64-linux";
        };
        "index" = {
          hostname = "index";
          address = "10.3.0.0";
          arch = "aarch64-linux";
        };
        #"tenshi" = {
        #    address = "10.4.0.0";
        #    arch = "x86_64-linux";
        #};
      };
    in {
      nixosConfigurations = lib.mapAttrs (hostname: info:
        nixpkgs-stable.lib.nixosSystem rec {
          system = info.arch;

          modules = [
            {
              nixpkgs.overlays = [
                (self: super: {
                  unstable = import "${nixpkgs-unstable}" {
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
            (agenix.nixosModules.age)
          ];
          specialArgs = {
            inherit inputs;
            inherit nur;
            inherit info;
            inherit nixpkgs;
            inherit home-manager;
            inherit agenix;
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
