{
  description = "Nixos minimal system";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05"; # now stable
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # for mango only
    waybar.url = "github:Alexays/Waybar";
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
      waybar,
      ...
    }:
    let
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        overlays = [
          waybar.overlays.waybar
          # spotdl forces YTMusic(language="de"); localized ("Titel") shelf titles
          # make ytmusicapi drop all songs-filter results. Default to en.
          (final: prev: {
            spotdl = prev.spotdl.overrideAttrs (old: {
              postPatch = (old.postPatch or "") + ''
                substituteInPlace spotdl/providers/audio/ytmusic.py \
                  --replace-fail 'return YTMusic(language="de")' 'return YTMusic()'
              '';
            });
          })
        ];
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
            ./modules/wifi.nix
            ./modules/kanata.nix
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
            ./modules/wifi.nix
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
