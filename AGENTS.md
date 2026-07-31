# AGENTS.md — Pakin's dotfiles (NixOS)

**Always ask for confirmation before making any changes.**

## Rebuild

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/dotfiles/nixos#nixos-T480
```

## Deploy non-NixOS assets

```sh
./update
```

This stows `files/` and `config/` with GNU stow, then builds dwl + someblocks via `sudo make clean install`. Run it after changing stow-managed configs (`config/`, `files/`, `wmenu-scripts/`).

## Architecture

- **NixOS flake** (`nixos/flake.nix`) declares system `nixos-T480` using nixpkgs unstable + home-manager master.
- **home-manager** (`nixos/home.nix`) manages user `pakin` and imports three modules:
  - `modules/homeFile.nix` — out-of-store symlinks for `files/` subdirs into `$HOME`
  - `modules/xdgConfig.nix` — out-of-store symlinks for `config/.config/*` into XDG config
  - `modules/theme.nix` — GTK Orchis-Dark, Papirus-Dark icons, Qt → GTK
- **GNU stow** (`update` script) handles files not managed by home-manager: `config/` (dotfiles in `$HOME`, e.g. `.zshrc`), `files/` (assets), `wmenu-scripts/`.
- **Zsh**: home-manager manages the package but source-loads dotfiles `.zshrc` / `.zshenv` / `.zprofile` from this repo.
- **dwl** + **someblocks** are git submodules under `build/`. Their builds are triggered by `./update`.
- `hardware-configuration.nix` is auto-generated — do not edit (use `/etc/nixos/configuration.nix` or this repo's `configuration.nix`).
- `nixpkgs.config.allowUnfree = true` is set.
- `nix.settings.experimental-features = [ "nix-command" "flakes" ]` is required.

## Config location map

| What | Where |
|---|---|
| NixOS system config | `nixos/configuration.nix` |
| Home-manager user config | `nixos/home.nix` + `nixos/modules/` |
| App configs (dwl, nvim, foot, waybar, rofi, etc.) | `config/.config/<app>/` |
| Shell dotfiles | `config/.zshrc`, `.zshenv`, `.zprofile` |
| Scripts | `files/Scripts/` |
| Buildable submodules | `build/dwl`, `build/someblocks` |
| Wallpapers | `files/Pictures/wallpapers/` |

## Other assets

- **image files** use Git LFS (`*.jpg`, `*.png`, `*.jpeg`, `*.svg`)
- **submodules** need `git submodule update --init --recursive` after clone
- leftover Void Linux references (runit, xbps aliases) exist in `.zshrc` — ignore on NixOS
- dwl config lives at `config/.config/dwl/`; `./update` symlinks it into the build dir
