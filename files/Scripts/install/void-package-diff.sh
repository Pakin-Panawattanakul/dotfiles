#!/bin/bash
# Diff packages referenced by xbps-install in void-install.sh against what
# xbps currently reports as installed. Packages inside optional,
# ask_install-gated functions (wireless_setup, install_nvidia, install_intel)
# are tracked separately since they're not expected to always be installed.
script_dir="$(cd "$(dirname "$0")" && pwd)"
install_script="$script_dir/void-install.sh"
optional_functions="wireless_setup install_nvidia install_intel"

# Packages that come from the void-installer itself (base system, kernel,
# bootloader) rather than from void-install.sh - never expected to show up
# there, so excluded from the "unreferenced" report.
base_install_pkgs="base-system
grub-i386-efi
grub-x86_64-efi
linux"

extract_pkgs() {
  # $1 = text block to scan for xbps-install invocations
  printf '%s\n' "$1" \
    | sed -e 's/#.*//' \
    | sed -e ':a' -e '/\\$/{N;s/\\\n/ /;ba}' \
    | grep 'xbps-install' \
    | sed 's/.*xbps-install//' \
    | tr ' ' '\n' \
    | grep -v '^-' \
    | sed '/^$/d' \
    | sort -u
}

optional_block=""
for fn in $optional_functions; do
  block="$(awk -v fn="$fn" '
    $0 ~ "^"fn"\\(\\)" {grab=1}
    grab {print; if ($0 ~ /^}/) {grab=0; exit}}
  ' "$install_script")"
  optional_block="$optional_block
$block"
done

full_text="$(cat "$install_script")"
optional_pkgs="$(extract_pkgs "$optional_block")"
all_pkgs="$(extract_pkgs "$full_text")"
required_pkgs="$(comm -23 <(printf '%s\n' "$all_pkgs") <(printf '%s\n' "$optional_pkgs"))"

manual_pkgs="$(xbps-query -m 2>/dev/null | sed -E 's/-[0-9][^-]*(_[0-9]+)?$//' | sort -u)"
installed_pkgs="$(xbps-query -l 2>/dev/null | awk '{print $2}' | sed -E 's/-[0-9][^-]*(_[0-9]+)?$//' | sort -u)"

echo "=== required packages referenced in void-install.sh but NOT installed at all ==="
comm -23 <(printf '%s\n' "$required_pkgs") <(printf '%s\n' "$installed_pkgs")

echo
echo "=== required packages installed only as a dependency (not manual) ==="
comm -23 <(comm -12 <(printf '%s\n' "$required_pkgs") <(printf '%s\n' "$installed_pkgs")) <(printf '%s\n' "$manual_pkgs")

echo
echo "=== optional packages (wireless/nvidia/intel) NOT installed at all ==="
comm -23 <(printf '%s\n' "$optional_pkgs") <(printf '%s\n' "$installed_pkgs")

echo
echo "=== manually installed but NOT referenced anywhere in void-install.sh ==="
comm -13 <(printf '%s\n' "$all_pkgs") <(printf '%s\n' "$manual_pkgs") | comm -23 - <(printf '%s\n' "$base_install_pkgs")
