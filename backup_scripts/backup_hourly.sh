#!/bin/sh
# Backup Script Written by Sergio Rivas

BACKUP_PATH="/TensorCloud/DockerInDocker/volumerize_backups"

# relabel last backup to past
if [ -f "$BACKUP_PATH"/"$APP_NAME"_current_hour.zip ]; then
  cp "$BACKUP_PATH"/"$APP_NAME"_current_hour.zip "$BACKUP_PATH"/"$APP_NAME"_past_hour.zip
fi

# backup via volumerize
docker exec volumerize_backup backup
zip -r "$BACKUP_PATH"/"$APP_NAME"_current_hour.zip backup_volume
