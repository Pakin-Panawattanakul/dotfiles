{
  description = "Nixos minimal system";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05"; # now stable
    # slang-server is not packaged on 26.05; build from source. submodules=1
    # pulls the vendored external/ deps (slang, reflect-cpp, ctre).
    slang-server.url = "git+https://github.com/hudson-trading/slang-server?submodules=1";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs, home-manager, slang-server, ... }:
    {
      nixosConfigurations = {
        nixos-T480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit slang-server; };
          modules = [
            ./hosts/hardware-configuration-T480.nix
            ./configuration.nix
            ./modules/battery.nix
            ./modules/wifi.nix
            ./modules/kanata.nix
            { networking.hostName = "nixos-T480"; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pakin = {
                  imports = [
                    ./home.nix
                    ./home-manager/books-library.nix
                  ];
                };
                backupFileExtension = "backup";
              };
            }
          ];
        };

        nixos-home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit slang-server; };
          modules = [
            ./hosts/hardware-configuration-home.nix
            ./configuration.nix
            ./modules/nvidia.nix
            { networking.hostName = "nixos-home"; }
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

        nixos-NV15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit slang-server; };
          modules = [
            ./hosts/hardware-configuration-NV15.nix
            ./configuration.nix
            ./modules/battery.nix
            ./modules/nvidia.nix
            ./modules/wifi.nix
            ./modules/kanata.nix
            { networking.hostName = "nixos-NV15"; }
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
