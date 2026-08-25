{ config, pkgs, lib, ... }:
let
  dwl =
    (pkgs.dwl.override {
      configH = ../config/.config/dwl/config.h;
    }).overrideAttrs
      (oldAttrs: {
        src = ../build/dwl;
        buildInputs = oldAttrs.buildInputs or [ ] ++ [
          pkgs.fcft
          pkgs.libdrm
        ];
      });
  someblocks = pkgs.stdenv.mkDerivation {
    name = "someblocks-1.0.1";
    pname = "someblocks";
    src = ../build/someblocks;
    makeFlags = [ "PREFIX=$(out)" ];
    postPatch = ''
      cp ${../config/.config/dwl/blocks.h} blocks.h
      sed -i 's/void termhandler()/void termhandler(int signum)/; s/void sigpipehandler()/void sigpipehandler(int signum)/' someblocks.c
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    dwl
    someblocks
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];

  services.displayManager.sessionPackages = [
    (pkgs.symlinkJoin {
      name = "dwl-session"; # 1. name of the merged store path
      paths = [ dwl ]; # 2. packages to union-merge
      passthru.providedSessions = [ "dwl" ]; # 3. metadata the option requires
    })
  ];
}
