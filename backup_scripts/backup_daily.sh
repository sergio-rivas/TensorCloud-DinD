#!/bin/sh
# Backup Script Written by Sergio Rivas

BACKUP_PATH="/TensorCloud/DockerInDocker/volumerize_backups"

# relabel last today to yesterday
if [ -f "$BACKUP_PATH"/"$APP_NAME"_today.zip ]; then
  cp "$BACKUP_PATH"/"$APP_NAME"_today.zip "$BACKUP_PATH"/"$APP_NAME"_yesterday.zip
fi

cp "$BACKUP_PATH"/"$APP_NAME"_past_hour.zip "$BACKUP_PATH"/"$APP_NAME"_today.zip
