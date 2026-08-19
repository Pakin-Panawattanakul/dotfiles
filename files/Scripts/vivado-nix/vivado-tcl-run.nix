{ pkgs ? import <nixpkgs> { } }:
(pkgs.buildFHSEnv {
  name = "vivado-env";
  targetPkgs = pkgs: (
    with pkgs; [
      ncurses5
      ncurses
      libxcrypt-legacy
      libpng
      libusb1
      systemd
      pixman
      zlib
      libuuid
      bash
      coreutils
      zlib
      stdenv.cc.cc
      libXext
      libX11
      libXrender
      libXtst
      libXi
      libXft
      libxcb
      libxcb
      freetype
      fontconfig
      glib
      gtk2
      gtk3
      graphviz
      gcc
      unzip
      nettools
    ]
  );
  profile = ''
    export LD_LIBRARY_PATH=/usr/lib:/usr/lib64:$LD_LIBRARY_PATH
  '';
  runScript = ''
    env LIBRARY_PATH=/usr/lib \
      C_INCLUDE_PATH=/usr/include \
      CPLUS_INCLUDE_PATH=/usr/include \
      CMAKE_LIBRARY_PATH=/usr/lib \
      CMAKE_INCLUDE_PATH=/usr/include \
      xterm -e /opt/Xilinx/2026.1/Vivado/bin/vivado -mode tcl
  '';
}).env
