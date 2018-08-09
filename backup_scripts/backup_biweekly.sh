#!/bin/sh
# Backup Script Written by Sergio Rivas

BACKUP_PATH="/TensorCloud/DockerInDocker/volumerize_backups"
BIWK="$BACKUP_PATH"/"$APP_NAME"_biwk.zip
WEEK="$BACKUP_PATH"/"$APP_NAME"_last_week.zip
DATE=$(date -r $WEEK +"%y%m%d")

# Initialize Biweekly if not present
if [ ! -f $BIWK ]; then
  cp $WEEK $BIWK
fi

# Relabel and date if there is a change in data. LONG-TERM STORAGE
if [ -f $BIWK ]; then
  cmp --silent $BIWK $WEEK && echo '### No Longterm Backup Created: Data Unchanged! ###' || cp $BIWK "$BACKUP_PATH"/"$APP_NAME"_biwk_"$DATE".zip
  cp $WEEK $BIWK
fi
