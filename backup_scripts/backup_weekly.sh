#!/bin/sh
# Backup Script Written by Sergio Rivas

BACKUP_PATH="/TensorCloud/DockerInDocker/volumerize_backups"

# relabel last week to this week
if [ -f "$BACKUP_PATH"/"$APP_NAME"_current_week.zip ]; then
  cp "$BACKUP_PATH"/"$APP_NAME"_current_week.zip "$BACKUP_PATH"/"$APP_NAME"_last_week.zip
fi

cp "$BACKUP_PATH"/"$APP_NAME"_past_hour.zip "$BACKUP_PATH"/"$APP_NAME"_current_week.zip
