#!/bin/bash
# Usage: ./compare-scans.sh before.nmap after.nmap
# Exit 1 means differences; exit 2 means an error, as with diff itself.
set -eu
exec diff -u "${1:?Supply the before.nmap file}" "${2:?Supply the after.nmap file}"
