#!/bin/sh
# trackpoint-setup.sh — set the ThinkPad TrackPoint's hardware sensitivity/speed
# and keep them applied across boot and resume.
#
# The knobs are sysfs attributes of the TrackPoint's serio port (psmouse
# driver). They reset to the kernel defaults (sensitivity=200, speed=97) on
# every boot, and psmouse may re-probe on resume, so a oneshot unit plus a
# sleep hook are installed instead of writing them by hand.
#
# Usage:
#   trackpoint-setup.sh install     install unit + sleep hook, apply now (root)
#   trackpoint-setup.sh apply       write the values once (root)
#   trackpoint-setup.sh status      show current values and unit state
#   trackpoint-setup.sh uninstall   remove everything this script installed (root)
#
# Both values are 1-255; 255 is the ceiling for both, since the kernel's
# sysfs setter parses them as u8 (kstrtou8) and writes the raw
# TP_SENS/TP_SPEED register. sensitivity is a straight multiplier on every
# delta; speed is a velocity-dependent boost curve. Raise sensitivity first,
# then use speed for fine tuning.
#
# Values come from /etc/default/trackpoint once installed. `apply` also honours
# TRACKPOINT_SENSITIVITY / TRACKPOINT_SPEED from the environment, which wins
# over the file, e.g.
#   sudo TRACKPOINT_SPEED=120 trackpoint-setup.sh apply

set -eu

PROG=$(basename "$0")
SELF=$(readlink -f "$0")

UNIT=trackpoint.service
UNIT_DIR=/etc/systemd/system
BIN=/usr/local/bin/trackpoint-setup
DEFAULTS=/etc/default/trackpoint
SLEEP_HOOK=/usr/lib/systemd/system-sleep/50-trackpoint

DEFAULT_SENSITIVITY=255
DEFAULT_SPEED=255

usage() {
	sed -n '2,/^set -eu$/p' "$SELF" | sed -e 's/^# \{0,1\}//' -e '$d'
}

die() {
	echo "$PROG: $*" >&2
	exit 1
}

need_root() {
	[ "$(id -u)" -eq 0 ] || die "must be run as root (use sudo)"
}

# TrackPoint serio ports are the only serio devices exposing both attributes.
devices() {
	for d in /sys/bus/serio/devices/*; do
		if [ -e "$d/sensitivity" ] && [ -e "$d/speed" ]; then
			printf '%s\n' "$d"
		fi
	done
}

validate() {
	case "$1" in
	'' | *[!0-9]*) die "$2 must be an integer 1-255, got '$1'" ;;
	esac
	if [ "$1" -lt 1 ] || [ "$1" -gt 255 ]; then
		die "$2 must be 1-255, got '$1'"
	fi
}

read_values() {
	# Environment first, so a one-off `apply` can override without editing
	# /etc/default/trackpoint.
	SENSITIVITY=${TRACKPOINT_SENSITIVITY:-}
	SPEED=${TRACKPOINT_SPEED:-}
	if [ -z "$SENSITIVITY" ] || [ -z "$SPEED" ]; then
		if [ -r "$DEFAULTS" ]; then
			# shellcheck disable=SC1090
			. "$DEFAULTS"
			SENSITIVITY=${SENSITIVITY:-${TRACKPOINT_SENSITIVITY:-$DEFAULT_SENSITIVITY}}
			SPEED=${SPEED:-${TRACKPOINT_SPEED:-$DEFAULT_SPEED}}
		fi
	fi
	SENSITIVITY=${SENSITIVITY:-$DEFAULT_SENSITIVITY}
	SPEED=${SPEED:-$DEFAULT_SPEED}
	validate "$SENSITIVITY" sensitivity
	validate "$SPEED" speed
}

do_apply() {
	need_root
	read_values

	# The unit can start before the serio port is populated; wait up to ~10s.
	attempt=0
	while [ -z "$(devices)" ]; do
		attempt=$((attempt + 1))
		[ "$attempt" -ge 20 ] && die "no TrackPoint serio device found (is psmouse loaded?)"
		sleep 0.5
	done

	for d in $(devices); do
		printf '%s\n' "$SENSITIVITY" >"$d/sensitivity"
		printf '%s\n' "$SPEED" >"$d/speed"
		echo "set $(basename "$d"): sensitivity=$SENSITIVITY speed=$SPEED"
	done
}

do_status() {
	state=$(systemctl is-enabled "$UNIT" 2>/dev/null || true)
	if [ -z "$state" ] || [ "$state" = "not-found" ]; then
		state="not installed"
	fi
	echo "unit: $UNIT is $state"

	found=0
	for d in $(devices); do
		found=1
		echo "$(basename "$d"): sensitivity=$(cat "$d/sensitivity") speed=$(cat "$d/speed")"
	done
	[ "$found" -eq 1 ] || echo "no TrackPoint serio device found"

	if [ -r "$DEFAULTS" ]; then
		echo "configured:"
		grep -E '^TRACKPOINT_(SENSITIVITY|SPEED)=' "$DEFAULTS" | sed 's/^/  /'
	fi
}

do_install() {
	need_root
	read_values

	install -Dm755 "$SELF" "$BIN"
	mkdir -p "$UNIT_DIR" "$(dirname "$DEFAULTS")" "$(dirname "$SLEEP_HOOK")"

	cat >"$DEFAULTS" <<EOF
# Written by $PROG. TrackPoint hardware knobs, each 1-255 (255 is the max the
# hardware accepts; this machine shipped with sensitivity=200 speed=97).
# Re-apply with:
#   sudo systemctl restart $UNIT
TRACKPOINT_SENSITIVITY=$SENSITIVITY
TRACKPOINT_SPEED=$SPEED
EOF

	cat >"$UNIT_DIR/$UNIT" <<EOF
[Unit]
Description=Set TrackPoint sensitivity/speed
After=systemd-udev-settle.service

[Service]
Type=oneshot
RemainAfterExit=yes
EnvironmentFile=-$DEFAULTS
ExecStart=$BIN apply

[Install]
WantedBy=multi-user.target
EOF

	cat >"$SLEEP_HOOK" <<EOF
#!/bin/sh
# Installed by $PROG.
# psmouse re-probes on some resumes and resets the TrackPoint sysfs knobs back
# to the kernel defaults, so re-run the unit after resuming.
[ "\${1:-}" = post ] || exit 0
exec systemctl restart $UNIT
EOF
	chmod 755 "$SLEEP_HOOK"

	systemctl daemon-reload
	systemctl enable "$UNIT" >/dev/null 2>&1
	systemctl restart "$UNIT"

	echo "installed $BIN, $UNIT_DIR/$UNIT, $SLEEP_HOOK, $DEFAULTS"
	echo "edit $DEFAULTS, then: sudo systemctl restart $UNIT"
}

do_uninstall() {
	need_root
	systemctl disable --now "$UNIT" >/dev/null 2>&1 || true
	rm -f "$UNIT_DIR/$UNIT" "$SLEEP_HOOK" "$BIN" "$DEFAULTS"
	systemctl daemon-reload
	# The sysfs values are left as-is; they revert on the next boot anyway.
	echo "removed $UNIT, $SLEEP_HOOK, $BIN, $DEFAULTS"
}

case "${1:-install}" in
install) do_install ;;
apply) do_apply ;;
status) do_status ;;
uninstall) do_uninstall ;;
-h | --help | help) usage ;;
*)
	usage
	exit 1
	;;
esac
