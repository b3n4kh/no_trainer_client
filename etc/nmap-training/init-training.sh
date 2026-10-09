#!/bin/bash
set -eu
if [ -n "${SSH_PASSWORD:-}" ]; then
    printf 'abc:%s\n' "$SSH_PASSWORD" | chpasswd
else
    passwd -l abc > /dev/null
fi
. /etc/profile.d/nmap-training.sh

if [ -n "$SCAN_INTERFACE" ]; then
    "$NMAP_TRAINING/scripts/multicast-routes.sh"
else
    echo "[nmap-training] No direct route to $SCAN_NETWORK; set SCAN_INTERFACE after connecting the lab network."
fi

# The desktop and existing SSH service use the LinuxServer abc account.
s6-setuidgid abc env HOME="$(getent passwd abc | cut -d: -f6)" \
    "$NMAP_TRAINING/scripts/setup-training.sh"
