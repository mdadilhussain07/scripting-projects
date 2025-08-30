#!/usr/bin/env bash
set -euo pipefail


# logging funtion with timestamp
log () { printf "[%s] %s\n\n" "$(date +'%F %T')" "$*"; }

log "Disk usage:"
df -h | sed -n '1,5p'

log "Top memory processes:"
ps aux --sort=-%mem | head -n 5

log "Open TCP listeners:"

if command -v ss &>/dev/null; then
	if ! ss -tuln 2>/dev/null | head -n 10; then
	    	echo "TCP listener check not supported in this environment"
	fi
elif command -v netstat &>/dev/null; then
	netstat -tuln | head -n 10
else
	echo "No network command available on this system"
fi
