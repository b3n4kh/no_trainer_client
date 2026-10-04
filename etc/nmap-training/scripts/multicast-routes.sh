#!/bin/bash
# Run as root (or with sudo) inside a training client.
set -eu
. /etc/profile.d/nmap-training.sh
: "${SCAN_INTERFACE:?No lab interface found; check ip -br address and set SCAN_INTERFACE}"

# Refuse a management/default route: the scan network must be directly attached.
if ! ip -o -4 route show "$SCAN_NETWORK" | \
    awk -v network="$SCAN_NETWORK" -v interface="$SCAN_INTERFACE" \
        '$1 == network && $2 == "dev" && $3 == interface {found=1} END {exit !found}'; then
    echo "No directly attached $SCAN_NETWORK on $SCAN_INTERFACE" >&2
    exit 1
fi
ip route replace 224.0.0.251/32 dev "$SCAN_INTERFACE"
ip route replace 239.255.255.250/32 dev "$SCAN_INTERFACE"
