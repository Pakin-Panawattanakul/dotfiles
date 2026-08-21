{
  description = "Nixos minimal system";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05"; # now stable
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # for mango only
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
      };
    in
    {
      nixosConfigurations = {
        nixos-T480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./hosts/hardware-configuration-T480.nix
            ./configuration.nix
            ./modules/battery.nix
            ./packages/nixos-T480.nix
            { networking.hostName = "nixos-T480"; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pakin = import ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit pkgs-unstable; };
              };
            }
          ];
        };

        nixos-home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./hosts/hardware-configuration-home.nix
            ./configuration.nix
            ./modules/nvidia.nix
            ./modules/wifi.nix
            ./packages/nixos-home.nix
            { networking.hostName = "nixos-home"; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pakin = import ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit pkgs-unstable; };
              };
            }
          ];
        };

        nixos-NV15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./hosts/hardware-configuration-NV15.nix
            ./configuration.nix
            ./modules/battery.nix
            ./modules/nvidia.nix
            ./modules/virtualbox.nix
            ./modules/wifi.nix
            #./packages/nixos-T480.nix
            { networking.hostName = "nixos-NV15"; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pakin = import ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit pkgs-unstable; };
              };
            }
          ];
        };
      };
    };
}
