#!/bin/sh

set -e

unset BUNDLE_PATH
unset BUNDLE_BIN

# Generate crontab with configurable schedule and imap-backup arguments
BACKUP_SCHEDULE="${BACKUP_SCHEDULE:-@daily}"
IMAP_BACKUP_ARGS="${IMAP_BACKUP_ARGS:-backup --config /data/config.json}"
CRONTAB_FILE="$(mktemp --tmpdir crontab.XXXXXXXXXX)"

{
  echo "# Email backup crontab - Generated at $(date)"
  echo "# Schedule: ${BACKUP_SCHEDULE}"
  echo "# Arguments: ${IMAP_BACKUP_ARGS}"
  echo "${BACKUP_SCHEDULE} imap-backup ${IMAP_BACKUP_ARGS}"
} > "$CRONTAB_FILE"

echo "Crontab generated to $CRONTAB_FILE"

# Use the generated crontab if running supercronic
if [ "$1" = "supercronic" ]; then
  supercronic "$CRONTAB_FILE"
else
  exec "$@"
fi
