---
name: apply-theme
description: Apply a color theme across every theme file in the dotfiles repo. Use when the user says to apply/switch/change a theme, e.g. "apply gruvbox", "switch to kanagawa dragon", "change theme everywhere". Lists all files that carry theme colors and how to update each.
---

# Apply Theme

Applies a new color palette to **every theme-bearing file** in `dotfiles`
(excluding `archives/`). Theme colors are sourced from the palette files in
`files/Templates/themes/`.

**Always ask for confirmation before editing** (repo rule, see `AGENTS.md`).
Ask the target theme and, if it's a named theme, whether the terminal/status
bar should keep the current palette or be remapped.

## Theme source

Canonical color palettes live one-per-theme in `files/Templates/themes/<name>`
(e.g. `gruvbox-dark`, `nvim-dark`, ...). Files use the foot palette format:
`[colors-dark]` with `cursor`/`foreground`/`background`/`selection-*` and
`regular0-7`/`bright0-7` (6-digit hex, no `#`), plus a `[colors-light]` block.

Per-app roles (bg, fg, red, green, ...) are derived from this source file when
applying a theme. To find every file a color lands in, grep a representative
hex from the source palette:

`grep -rn '<hex>' --exclude-dir={archives,node_modules,submodules,eza-themes,.git,.github} .`

## Master theme file list

| # | File | What carries the theme |
|---|------|------------------------|
| 1 | `config/.config/eza/theme.yml` | **Symlink** — repoint to `eza-themes/themes/<name>.yml` (kanagawa-dragon.yml, gruvbox-dark.yml, catppuccin-mocha.yml, ...) |
| 2 | `config/.config/nvim/lua/plugins/themes.lua` | **DO NOT TOUCH** — user configures nvim theme themselves. When applying a theme, skip this file and remind the user to update their nvim theme to match. |
| 3 | `config/.config/foot/foot.ini` | `[colors-dark]` ANSI block — sync with `files/Templates/themes/<name>`: `cursor`/`foreground`/`background`/`selection-*`/`regular0-7`/`bright0-7`. 6-digit hex, no `#`, `alpha=0.9`. |
| 4 | `files/Templates/themes/<name>` | **Theme source** — canonical per-theme palette (foot format). Reference/edit this when introducing or changing a theme. |
| 5 | `config/.config/dwl/config.h` | `rootcolor` + `colors[][3]` at lines ~42-53: `SchemeNorm/Sel/Urg/Bar`, each `{ fg, bg, border }`. Format `0xRRGGBBff`. |
| 6 | `config/.config/dwl/blocks.h` | someblocks status bar: `^fg(hex)` markers inside block commands (brightness, keymap, volume, wifi, battery, date, time). |
| 7 | `config/.config/dwl/autostart` | `waylock` colors: `-init-color 0xRRGGBB -input-color 0xRRGGBB -fail-color 0xRRGGBB`. |
| 8 | `home.nix` | **Real mako config** (`services.mako.settings`): `background-color`, `text-color`, `border-color`. This is what's deployed. |
| 9 | `config/.config/mako/config` | mako colors via symlink — **inert leftover** (mako is nix-managed in `home.nix`). Update only to keep the file consistent. |
| 10 | `config/.config/ncspot/config.toml` | `[theme]` keys: `background, primary, secondary, title, playing, playing_selected, playing_bg, highlight, highlight_bg, error, error_bg, statusbar, statusbar_progress, statusbar_bg, cmdline, cmdline_bg`. |
| 11 | `config/.zprofile` | `BEMENU_OPTS` bemenu colors: `--tf --tb --nf --nb --ff --fb --hf --hb --af --ab`. Backgrounds use 8-digit hex `#RRGGBBe6`. |
| 12 | `config/.zshrc` | `FZF_DEFAULT_OPTS` `--color=` values (spinner/hl/fg/bg/header/info/pointer/marker/fg+/prompt/hl+/bg+/border). |
| 13 | `config/.zshenv` | `BAT_THEME=<bat-builtin-name>` (bat has no kanagawa; keeps `gruvbox-dark` as closest). |
| 14 | `nixos/home-manager/theme.nix` | GTK theme (`gtk.theme`, `GTK_THEME`, `dconf` gtk-theme) + icon theme. Only for GTK themes packaged in nixpkgs. |
| 15 | `config/.config/starship.toml` | No colors currently (symbol overrides only); theme only if user adds a starship palette/preset. |
| 16 | `config/.profile` | `LOCK_INIT_COLOR` / `LOCK_INPUT_COLOR` / `LOCK_FAIL_COLOR` (`0xRRGGBB`) — waylock colors consumed by lock/powermenu scripts (e.g. `wmenu-powermenu`). Keep in sync with `config/.config/dwl/autostart`. |

## Apply flow

1. Confirm target theme + scope with the user.
2. Create or pick `files/Templates/themes/<name>` as the reference palette.
3. Run every file in the master list through the mapping; edit each hex/value.
   - `eza/theme.yml`: `ln -sfn eza-themes/themes/<name>.yml config/.config/eza/theme.yml`
   - **Skip `config/.config/nvim/lua/plugins/themes.lua`** — the user handles their
     nvim theme themselves.
   - Keep `foot.ini` and `files/Templates/themes/<name>` dark section identical.
   - Keep `config/.config/mako/config` matching `home.nix` mako colors.
   - Apps that don't map 1:1 from the palette (e.g. waylock status colors, `bat`
     theme in `.zshenv`) get the closest match chosen manually.
4. Verify: grep for leftover hexes from the previous theme source (grep pattern
   above).
5. **Remind the user**: the nvim theme was skipped — they need to configure
   `config/.config/nvim/lua/plugins/themes.lua` themselves to match the new theme.
6. Tell the user what needs redeploy/restart (below).

## Deploy/restart notes

- `nixos/home.nix`, `nixos/home-manager/theme.nix`, dwl (`config.h`/`blocks.h` are
  compiled), mako → `sudo nixos-rebuild switch --flake ~/'dotfiles/nixos?submodules=1#'nixos-T480` (`rebuild` alias).
- `foot`, `ncspot`, `eza` → reload the app.
- `nvim` → **not touched** by this skill; user reloads/updates their theme
  themselves after configuring `config/.config/nvim/lua/plugins/themes.lua`.
- `.zshrc` / `.zprofile` / `.zshenv` / `.profile` → new shell or login.
- `dwl/autostart` (waylock) → applies on next lock.
