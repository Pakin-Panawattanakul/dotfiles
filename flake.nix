{
  description = "Nixos minimal system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        config.allowUnfree = true;
        inherit system;
      };
      mkHost =
        {
          hostName,
          hardwareConfig,
          extraModules ? [ ],
          users ? { },
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs-unstable;
          };
          modules = [
            hardwareConfig
            ./configuration.nix
            { networking.hostName = hostName; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit pkgs-unstable;
                };
                users = nixpkgs.lib.mapAttrs (username: userConfig: {
                  imports = [
                    ./home.nix # common home-manager modules
                  ]
                  ++ (userConfig.imports or [ ]);
                }) users;
                backupFileExtension = "backup";
              };
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        nixos-T480 = mkHost {
          hostName = "nixos-T480";
          hardwareConfig = ./hosts/hardware-configuration-T480.nix;
          extraModules = [
            ./modules/battery.nix
            ./modules/wifi.nix
            ./modules/ly.nix
            ./modules/dwl.nix
            ./modules/kanata.nix
          ];
          users = {
            pakin = {
              imports = [
                ./home-manager/books-library.nix
              ];
            };
          };
        };

        nixos-home = mkHost {
          hostName = "nixos-home";
          hardwareConfig = ./hosts/hardware-configuration-home.nix;
          extraModules = [
            ./modules/nvidia.nix
            ./modules/kde.nix
            ./modules/dwl.nix
          ];
          users = {
            pakin = { };
          };
        };
      };
    };
}
