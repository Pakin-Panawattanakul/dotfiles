# AGENTS.md — Pakin's nixos-dotfiles (NixOS)

**Always ask for confirmation before making any changes.**

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/'nixos-dotfiles?submodules=1#'nixos-T480
```

`?submodules=1` is required so git submodules are included in the flake source (not just the pointer commits). Hosts: `nixos-T480`, `nixos-home`, `nixos-NV15`. A `rebuild` alias in `config/.zshrc` does the same using `$HOST` (set per-host in `.zprofile`/`.zshenv`). After clone, run `git submodule update --init --recursive` — note `config/.config/eza/eza-themes` is itself a nested submodule.

## Deploy non-NixOS assets

**Do NOT run `./update` on the NixOS system.** Configs are deployed via `sudo nixos-rebuild switch` → home-manager → `home-manager/config-symlink.nix`, which creates out-of-store **symlinks** from `config/` and `files/` into `~/.config` and `~/`. `./update` (GNU stow + dwl/someblocks builds) lives in `archives/` and is a leftover from the non-NixOS (Void) setup.

## Architecture

- **NixOS flake** at repo root (`flake.nix`) declares hosts `nixos-T480`, `nixos-home`, `nixos-NV15` using nixpkgs stable (`nixos-26.05`) + home-manager `release-26.05`. `slang-server` (not packaged on 26.05) is tracked as a pinned `git+…?submodules=1` input (vendored deps), threaded via `specialArgs` and built into `pkgs` through an overlay in `configuration.nix` (source of truth: `pkgs/slang-server.nix`). ncspot comes from stable nixpkgs (v1.4.0, includes the login-API fix).
- **Per-host wiring** lives in `flake.nix`: each `nixosSystem` imports `./hosts/hardware-configuration-<host>.nix`, `./configuration.nix`, its own `modules/` set, and home-manager. Wiring today:
  - `nixos-T480`: `modules/battery.nix`, `modules/wifi.nix`, `modules/kanata.nix`; home-manager also imports `./home-manager/books-library.nix`
  - `nixos-home`: `modules/nvidia.nix`
  - `nixos-NV15`: `modules/battery.nix`, `modules/nvidia.nix`, `modules/wifi.nix`, `modules/kanata.nix`
  - T480/NV15 set `home-manager.users.pakin.imports`, home/NV15 use `users.pakin = import ./home.nix`
  - `modules/udev.nix` + `modules/dwl.nix` are imported from shared `configuration.nix`. Other modules (`tailscale`, `virtualbox`, `synology-drive`) exist but are not wired into any host.
- **home-manager** (`home.nix` = user `pakin`) imports modules from `home-manager/`:
  - `config-symlink.nix` — the **only** place that symlinks `config/.config/*` and `files/*` out of the Nix store. Curated lists inside it (`xdgConfigs`, `homeFiles`); add new app configs here, **not** `xdg.configFile`.
  - `theme.nix` — GTK Orchis-Dark + Papirus-Dark + dconf. Keep Qt/Wayland session vars in mind (mako note: conflicts with plasma6's notifications; plasma6 not used).
  - plus `neovim.nix`, `terminal.nix` (foot/zsh/oh-my-zsh/tmux/starship), `firefox.nix` (reads `files/Templates/user.js` + `icons/*.svg`), `wayland.nix` (wlroots utils + wmenu scripts from `submodules/wmenu-scripts`), `music.nix`, `desktop-utils.nix`, `books-library.nix`. `rclone-gdrive.nix` and `synology-drive.nix` are present but commented out in `home.nix`.
- **dwl** + **someblocks** are git submodules under `submodules/`. `modules/dwl.nix` builds dwl from the submodule source, overriding `config.h`, and builds someblocks with `config/.config/dwl/blocks.h` injected (no `./update` needed).
- **opencode**: installed via home-manager (`terminal.nix`), and its config `config/.config/opencode/opencode.jsonc` **is** symlinked by `config-symlink.nix` — it is nix/managed. Repo-local `.opencode/` (skills, plugins) is separate from the user config.
- `hosts/*.nix` hardware configs are auto-generated — do not edit (add to `configuration.nix` instead).
- `nixpkgs.config.allowUnfree = true` and `nix.settings.experimental-features = [ "nix-command" "flakes" ]` are set.
- **`archives/`** collects configs of software no longer in use (sway, hypr, i3, awesome, kitty, mango, runit/Void leftovers) — git-tracked, not deployed.

## Config location map

| What | Where |
|---|---|
| NixOS flake / lockfile / per-host wiring | `flake.nix`, `flake.lock` |
| NixOS system config (shared) | `configuration.nix` |
| Per-host hardware configs (generated, don't edit) | `hosts/hardware-configuration-<host>.nix` |
| System modules | `modules/` (battery, dwl, kanata, nvidia, udev, wifi) |
| Home-manager user config + modules | `home.nix` + `home-manager/` |
| Symlinked app configs (declared in `config-symlink.nix`: dwl, eza, foot, ncspot, nvim, opencode, yt-dlp/plugins, starship.toml, xdg-desktop-portal, xkb) | `config/.config/<app>/` |
| Shell dotfiles (sourced by `home-manager/terminal.nix`) | `config/.zshrc`, `.zshenv`, `.zprofile`, `.profile`, `.bashrc`, `.tmux.conf` |
| Symlinked home dirs / files (Scripts, Templates, wallpapers) | `files/` |
| Launcher icons (used by `home-manager/firefox.nix`) | `icons/` |
| Buildable submodules (dwl, someblocks, bgutil-ytdlp-pot-provider, wmenu-scripts) | `submodules/` |
| Disused configs archive (git-tracked) | `archives/` |

## Other assets

- **image files** use Git LFS (`*.jpg`, `*.png`, `*.jpeg`, `*.svg`) — no extra setup needed, just don't treat LFS pointers as broken files.
- shell is zsh managed by home-manager; `terminal.nix` `source`s `config/.zshrc` etc. — edit there, not `/etc` shells.
- dwl config lives at `config/.config/dwl/` (`config.h`, `blocks.h`, `autostart`, `start-dwl`), consumed by `modules/dwl.nix`.
- `.zshrc` has a non-NixOS fallback block (oh-my-zsh bootstrap) plus aliases for `rebuild`, `nixgc`, spotdl/`music-sync`, and the pot-provider (radicale/ytdlp) that `cd`s into `submodules/bgutil-ytdlp-pot-provider`.