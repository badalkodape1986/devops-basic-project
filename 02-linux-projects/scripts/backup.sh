#!/bin/bash
set -e

SOURCE_DIR="/home/$USER/data"
BACKUP_DIR="/home/$USER/backups"
TIMESTAMP=$(date +%F_%H-%M-%S)

mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/data_backup_$TIMESTAMP.tar.gz" "$SOURCE_DIR"

echo "✅ Backup completed: $BACKUP_DIR/data_backup_$TIMESTAMP.tar.gz"
