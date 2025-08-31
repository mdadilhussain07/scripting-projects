#!/usr/bin/env bash
set -euo pipefail


# logging funtion with timestamp
log () { printf "[%s] %s\n\n" "$(date +'%F %T')" "$*"; }

check_disk() {
log "Disk usage:"
df -h | sed -n '1,5p'
}

check_memory() {
log "Top memory processes:"
ps aux --sort=-%mem | head -n 5
}

check_network() {
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
}

# Arguments handling
case "${1:-all}" in
	disk) check_disk ;;
	memory) check_memory ;;
	netowrk) check_network ;;
	all) check_disk; check_memory; check_network ;;
	*) echo " Usage : $0 {disk|memory|network}" ;;
esac
