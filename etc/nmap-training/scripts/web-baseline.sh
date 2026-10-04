#!/bin/bash
# Usage: ./web-baseline.sh [day1-web-before|day3-web-control|day3-web-after]
set -eu
exec nmap -n -sT -sV --version-light -p 80,443 \
    -oA "${1:-day1-web-before}" 172.28.50.20 172.28.50.21
