{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      extraConfig = builtins.readFile ../files/Templates/user.js;
      search = {
        force          = true;
        default        = "google";
        privateDefault = "google";

        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }];
            icon           = ../icons/nix-packages.svg;
            definedAliases = [ "np" ];
          };

          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }];
            icon           = ../icons/nix-options.svg;
            definedAliases = [ "no" ];
          };

          "NixOS Wiki" = {
            urls = [{
              template = "https://wiki.nixos.org/w/index.php";
              params   = [ { name = "search"; value = "{searchTerms}"; } ];
            }];
            icon           = ../icons/nix-wiki.svg;
            definedAliases = [ "nw" ];
          };

          "MyNixOS" = {
            urls            = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            icon            = ../icons/mynixos.svg;
            definedAliases  = [ "mn" ];
          };

          "Arch Wiki" = {
            urls           = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
            icon           = ../icons/arch_wiki.svg;
            definedAliases = [ "aw" ];
          };

          youtube = {
            urls           = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
            icon           = ../icons/youtube.svg;
            definedAliases = [ "yt" ];
          };
        };
      };
    };
  };
}
