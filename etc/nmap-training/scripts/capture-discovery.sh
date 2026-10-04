#!/bin/bash
# Usage: sudo ./capture-discovery.sh [day3-discovery.pcapng]
set -eu
. /etc/profile.d/nmap-training.sh
: "${LAB_IF:?No lab interface found; check SCAN_INTERFACE}"
exec tshark -i "$LAB_IF" -a duration:60 \
    -f 'arp or (udp and (port 67 or 68 or 5353 or 1900))' \
    -w "${1:-day3-discovery.pcapng}"
