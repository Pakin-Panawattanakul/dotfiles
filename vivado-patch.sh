#!/bin/sh
# Patch Vivado to run on Debian (forky/sid). Run with sudo.

set -e

# 1. Vivado's linker looks for glibc CRT objects in /usr/lib
ln -sf /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/crt1.o
ln -sf /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/crti.o
ln -sf /usr/lib/x86_64-linux-gnu/crtn.o /usr/lib/crtn.o

# 2. bookworm repo, needed only for libncurses5 (gone from forky/sid).
#    Kept out of debian-install.sh; only write the entry when bookworm isn't
#    already configured, so re-runs don't duplicate it (apt warns about sources
#    "configured multiple times").
if ! grep -rqs 'bookworm' /etc/apt/sources.list /etc/apt/sources.list.d/; then
  cat > /etc/apt/sources.list.d/bookworm.list <<'EOF'
deb http://deb.debian.org/debian/ bookworm main
EOF
fi

# Pin bookworm low so it is never picked up implicitly, only via `-t bookworm`.
cat > /etc/apt/preferences.d/bookworm <<'EOF'
Package: *
Pin: release n=bookworm
Pin-Priority: 50
EOF

apt update
apt install -t bookworm libncurses5
