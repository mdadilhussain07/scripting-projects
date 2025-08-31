#!/usr/bin/env bash

# This script is for storing backup file in compress form

set -euo pipefail

log () { printf "[%s] %s\n" "$(date +'%F %T')" "$*"; }

# variable

SRC_DIR=${1:-data}		  # Folder to back up (default = data if user gives nothing).
DEST_DIR=backups	          # Where backups will be stored.
TS=$(date +%F_%H%M) 	          # Timestamp.
FILENAME="backup_${TS}.tar.gz"	  # Final backup filename.

# test output
log "Source dir: $SRC_DIR"
log "Backup will be: $DEST_DIR/$FILENAME"

# Ensure backup directory exists
mkdir -p "$DEST_DIR"

# Create compressed backup

if ! tar -czf "$DEST_DIR/$FILENAME" "$SRC_DIR" 2>/dev/null; then
log " Some files could not be read. Try running with sudo for a full backup."
fi

# Log success
log "Backup created: $DEST_DIR/$FILENAME"


