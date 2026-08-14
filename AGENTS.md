# AGENTS.md — Pakin's dotfiles (NixOS)

**Always ask for confirmation before making any changes.**

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/'dotfiles?submodules=1#'nixos-T480
```

`?submodules=1` is required so the `build/dwl` + `build/someblocks` submodules are included in the flake source. Other hosts: `nixos-home`, `nixos-NV15`. There's also a `rebuild` alias in `config/.zshrc` using `$HOST`.

## Deploy non-NixOS assets

**Do NOT run `./update` on the NixOS system.** Configs are deployed via `sudo nixos-rebuild switch` → home-manager, which symlinks from `config/` and `files/` through `home-manager/configSymlink.nix`. `./update` (GNU stow + dwl/someblocks builds) is a leftover from the non-NixOS (Void) setup, archived in `archive-dotfiles/`.

## Architecture

- **NixOS flake** at repo root (`flake.nix`) declares hosts `nixos-T480`, `nixos-home`, `nixos-NV15` using nixpkgs stable + home-manager release.
- **home-manager** (`home.nix`) manages user `pakin` and imports modules from `home-manager/`:
  - `configSymlink.nix` — out-of-store symlinks for select `config/.config/*` and `files/` subdirs
  - `theme.nix` — GTK Orchis-Dark, Papirus-Dark icons, Qt → GTK
- **dwl** + **someblocks** are git submodules under `build/`. `modules/dwl.nix` builds them from source (no `./update` needed).
- **opencode** is nix-managed (`home.nix` via `programs.opencode.package = pkgs-unstable.opencode`); its config at `~/.config/opencode/opencode.jsonc` is standalone and **not** stow/nix-managed.
- `hosts/*.nix` hardware configs are auto-generated — do not edit (use `configuration.nix`).
- `nixpkgs.config.allowUnfree = true` is set.
- `nix.settings.experimental-features = [ "nix-command" "flakes" ]` is required.
- **`archive-dotfiles/`** is a separate git repo (Pakin-Panawattanakul/archive-dotfiles) nested inside this repo and left untracked; it collects configs of software no longer in use.

## Config location map

| What | Where |
|---|---|
| NixOS flake / lockfile | `flake.nix`, `flake.lock` |
| NixOS system config | `configuration.nix` |
| Per-host hardware configs | `hosts/hardware-configuration-<host>.nix` |
| System modules (dwl, battery, nvidia) | `modules/` |
| Per-host package lists | `packages/` |
| Home-manager user config | `home.nix` + `home-manager/` |
| Launcher icons (used by `home-manager/firefox.nix`) | `Icons/` |
| App configs (dwl, nvim, foot, waybar, rofi, etc.) | `config/.config/<app>/` |
| Shell dotfiles | `config/.zshrc`, `.zshenv`, `.zprofile` |
| Scripts | `files/Scripts/` |
| Buildable submodules | `build/dwl`, `build/someblocks` |
| Wallpapers | `files/Pictures/wallpapers/` |
| Old dotfiles archive (separate git repo) | `archive-dotfiles/` |

## Other assets

- **image files** use Git LFS (`*.jpg`, `*.png`, `*.jpeg`, `*.svg`)
- **submodules** need `git submodule update --init --recursive` after clone
- leftover Void Linux references (runit, xbps aliases) exist in `.zshrc` — ignore on NixOS
- dwl config lives at `config/.config/dwl/` (config.h, blocks.h), consumed by `modules/dwl.nix`
