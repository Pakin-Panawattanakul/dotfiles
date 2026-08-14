{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    fzf
    nodejs
    rustc
    cargo
    gcc
    python3
    tree-sitter
    unzip
    gnumake
  ];
}
