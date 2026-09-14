{
  lib,
  stdenv,
  cmake,
  ninja,
  pkg-config,
  python3,
  clang-tools,
  boost,
  fmt,
  openssl,
  tomlplusplus,
  zlib,
  src,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "slang-server";
  version = lib.trim (builtins.readFile "${src}/VERSION");

  strictDeps = true;
  __structuredAttrs = true;

  # slang-server fetches external/slang, external/reflect-cpp and external/ctre
  # as git submodules, so src must come from a source with submodules included.
  inherit src;

  nativeBuildInputs = [ cmake ninja pkg-config python3 ]
  ++ lib.optionals stdenv.cc.isClang [
    # Pick up the `clang-scan-deps` wrapper for CMake; see:
    # https://github.com/NixOS/nixpkgs/issues/452260
    clang-tools
  ];

  buildInputs = [ boost fmt openssl tomlplusplus zlib ];

  cmakeFlags = [
    (lib.cmakeBool "SLANG_SERVER_INCLUDE_TESTS" false)
    (lib.cmakeBool "SLANG_INCLUDE_TESTS" false)
    (lib.cmakeBool "SLANG_USE_MIMALLOC" false)
    (lib.cmakeBool "SLANG_USE_SYSTEM_BOOST" true)
    (lib.cmakeBool "SLANG_SERVER_USE_SYSTEM_FMT" true)
  ];

  meta = {
    description = "SystemVerilog language server";
    homepage = "https://github.com/hudson-trading/slang-server";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    mainProgram = "slang-server";
  };
})