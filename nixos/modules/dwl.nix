{
  config,
  pkgs,
  lib,
  ...
}:
let
  dwl =
    (pkgs.dwl.override {
      configH = ../../config/.config/dwl/config.h;
    }).overrideAttrs
      (oldAttrs: {
        src = ../../build/dwl;

        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
          pkgs.fcft
          pkgs.libdrm
        ];
      });

  someblocks = pkgs.stdenv.mkDerivation {
    pname = "someblocks";
    version = "1.0.1";

    src = ../../build/someblocks;

    makeFlags = [ "PREFIX=$(out)" ];

    postPatch = ''
      cp ${../../config/.config/dwl/blocks.h} blocks.h
      sed -i \
        's/void termhandler()/void termhandler(int signum)/;
         s/void sigpipehandler()/void sigpipehandler(int signum)/' \
        someblocks.c
    '';
  };
in
{
  programs.dwl = {
    enable = true;
    package = dwl;
  };

  environment.systemPackages = [
    someblocks
  ];

  services.displayManager.sessionPackages = [
    (pkgs.symlinkJoin {
      name = "dwl-session";
      paths = [ dwl ];
      passthru.providedSessions = [ "dwl" ];
    })
  ];

  xdg.portal = {
    enable = true;

    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
