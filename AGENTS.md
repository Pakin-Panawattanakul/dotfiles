# AGENTS.md — Pakin's dotfiles (NixOS)

**Always ask for confirmation before making any changes.**

## Rebuild

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/dotfiles/nixos#nixos-T480
```

## Deploy non-NixOS assets

**Do NOT run `./update` on the NixOS system.** Configs are deployed via `sudo nixos-rebuild switch` → home-manager, which symlinks from `config/` and `files/` through `nixos/home-manager/configSymlink.nix`. `./update` (GNU stow + dwl/someblocks builds) is a leftover from the non-NixOS (Void) setup and is not used here.

## Architecture

- **NixOS flake** (`nixos/flake.nix`) declares system `nixos-T480` using nixpkgs unstable + home-manager master.
- **home-manager** (`nixos/home.nix`) manages user `pakin` and imports modules from `nixos/home-manager/`:
  - `configSymlink.nix` — out-of-store symlinks for select `config/.config/*` and `files/` subdirs
  - `theme.nix` — GTK Orchis-Dark, Papirus-Dark icons, Qt → GTK
- **dwl** + **someblocks** are git submodules under `build/`. Their builds are triggered by `./update` (legacy, non-NixOS only).
- **opencode** is nix-managed (`nixos/home.nix` via `programs.opencode.package = pkgs-unstable.opencode`); its config at `~/.config/opencode/opencode.jsonc` is standalone and **not** stow/nix-managed.
- `hardware-configuration.nix` is auto-generated — do not edit (use `/etc/nixos/configuration.nix` or this repo's `configuration.nix`).
- `nixpkgs.config.allowUnfree = true` is set.
- `nix.settings.experimental-features = [ "nix-command" "flakes" ]` is required.

## Config location map

| What | Where |
|---|---|
| NixOS system config | `nixos/configuration.nix` |
| Home-manager user config | `nixos/home.nix` + `nixos/home-manager/` |
| App configs (dwl, nvim, foot, waybar, rofi, etc.) | `config/.config/<app>/` |
| Shell dotfiles | `config/.zshrc`, `.zshenv`, `.zprofile` |
| Scripts | `files/Scripts/` |
| Buildable submodules | `build/dwl`, `build/someblocks` |
| Wallpapers | `files/Pictures/wallpapers/` |

## Other assets

- **image files** use Git LFS (`*.jpg`, `*.png`, `*.jpeg`, `*.svg`)
- **submodules** need `git submodule update --init --recursive` after clone
- leftover Void Linux references (runit, xbps aliases) exist in `.zshrc` — ignore on NixOS
- dwl config lives at `config/.config/dwl/`; `./update` symlinks it into the build dir (legacy, non-NixOS only)
