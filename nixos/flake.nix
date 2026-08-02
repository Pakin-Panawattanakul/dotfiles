{
  description = "Nixos minimal system";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";   # now stable
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";     # for mango only
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
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
            ./configuration.nix
            ./hosts/T480/hardware-configuration.nix
            ./hosts/T480/T480.nix
            { networking.hostName = "nixos-T480";} 
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
        nixos-home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./configuration.nix
            ./hosts/home/hardware-configuration.nix
            ./hosts/home/home.nix
            { networking.hostName = "nixos-home";} 
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
