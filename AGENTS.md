# AGENTS.md — Pakin's nixos-dotfiles (NixOS)

**Always ask for confirmation before making any changes.**

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/'nixos-dotfiles?submodules=1#'nixos-T480
```

`?submodules=1` is required so the `build/*` submodules are included in the flake source. Other hosts: `nixos-home`, `nixos-NV15`. There's also a `rebuild` alias in `config/.zshrc` using `$HOST`. After clone, run `git submodule update --init --recursive`.

## Deploy non-NixOS assets

**Do NOT run `./update` on the NixOS system.** Configs are deployed via `sudo nixos-rebuild switch` → home-manager, which symlinks from `config/` and `files/` through `home-manager/configSymlink.nix`. `./update` (GNU stow + dwl/someblocks builds) lives in `archives/` and is a leftover from the non-NixOS (Void) setup.

## Architecture

- **NixOS flake** at repo root (`flake.nix`) declares hosts `nixos-T480`, `nixos-home`, `nixos-NV15` using nixpkgs stable (`nixos-26.05`) + home-manager release. `pkgs-unstable` is threaded through `extraSpecialArgs`/`specialArgs` for `nixos-unstable`, `waybar` (overlay), and a `spotdl` overlay patch.
- **Per-host setup** is split across `configuration.nix` (shared config + `modules/` imports) and per-host `packages/nixos-<host>.nix`; each host also wires its own `modules/` (e.g. T480 uses `battery`/`wifi`/`kanata`, NV15 uses `battery`/`wifi`/`nvidia`).
- **home-manager** (`home.nix` = user `pakin`) imports modules from `home-manager/`:
  - `configSymlink.nix` — out-of-store symlinks for select `config/.config/*` (dwl, eza, foot, nvim, rofi, yazi, starship.toml, etc.) and `files/` subdirs (`Pictures/wallpapers`, `Scripts`, `Templates`, ...). Add new app configs here, not to `xdg.configFile`.
  - `theme.nix` — GTK Orchis-Dark, Papirus-Dark icons, forces qt platformtheme=gtk3 (**conflicts with plasma6**)
  - plus `neovim.nix`, `terminal.nix` (foot/zsh/oh-my-zsh/tmux/starship/yazi), `firefox.nix` (reads `files/Templates/user.js` + `icons/*.svg`), `rclone-gdrive.nix`
- **dwl** + **someblocks** (+ `bgutil-ytdlp-pot-provider`) are git submodules under `build/`. `modules/dwl.nix` builds dwl from the submodule source, overriding `config.h` + injecting `config/.config/dwl/blocks.h` into someblocks (no `./update` needed).
- **opencode** is nix-managed (`home.nix` via `programs.opencode.package = pkgs-unstable.opencode`); its config `~/.config/opencode/opencode.jsonc` is standalone and **not** stow/nix-managed.
- `hosts/*.nix` hardware configs are auto-generated — do not edit (add to `configuration.nix` instead).
- `nixpkgs.config.allowUnfree = true` and `nix.settings.experimental-features = [ "nix-command" "flakes" ]` are set.
- **`archives/`** collects configs of software no longer in use (sway, hypr, i3, awesome, kitty, runit/Void leftovers) — git-tracked, not deployed.

## Config location map

| What | Where |
|---|---|
| NixOS flake / lockfile | `flake.nix`, `flake.lock` |
| NixOS system config (shared) | `configuration.nix` |
| Per-host hardware configs (generated, don't edit) | `hosts/hardware-configuration-<host>.nix` |
| System modules (dwl, battery, kanata, nvidia, udev, virtualbox, wifi) | `modules/` |
| Per-host NixOS package lists | `packages/nixos-<host>.nix` |
| Home-manager package lists (stable/unstable split) | `packages/stable.nix`, `packages/unstable.nix` |
| Home-manager user config | `home.nix` + `home-manager/` |
| Launcher icons (used by `home-manager/firefox.nix`) | `icons/` |
| Out-of-store symlinked app configs (dwl, nvim, foot, rofi, yazi, etc.) | `config/.config/<app>/` |
| Shell dotfiles (sourced by `home-manager/terminal.nix`) | `config/.zshrc`, `.zshenv`, `.zprofile`, `.bashrc`, `.tmux.conf` |
| Scripts (symlinked) | `files/Scripts/` |
| Buildable submodules | `build/dwl`, `build/someblocks`, `build/bgutil-ytdlp-pot-provider` |
| Wallpapers (symlinked) | `files/Pictures/wallpapers/` |
| Disused configs archive (git-tracked) | `archives/` |

## Other assets

- **image files** use Git LFS (`*.jpg`, `*.png`, `*.jpeg`, `*.svg`)
- shell is zsh managed by home-manager (`terminal.nix`), which `source`s `config/.zshrc` etc. — edit there, not `/etc` shells
- leftover Void Linux references (runit, xbps aliases) exist in `.zshrc` — ignore on NixOS
- dwl config lives at `config/.config/dwl/` (config.h, blocks.h), consumed by `modules/dwl.nix`
