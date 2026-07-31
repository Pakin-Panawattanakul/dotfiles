{
  description = "Nixos minimal system";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        nixos-T480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hosts/T480/hardware-configuration.nix
            ./hosts/T480/T480.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pakin = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
        nixos-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hosts/desktop/hardware-configuration.nix
            ./host/desktop/desktop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pakin = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };
    };
}
