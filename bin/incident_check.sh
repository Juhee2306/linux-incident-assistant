#!/bin/bash

LOG_DIR="../logs"
LOG_FILE="$LOG_DIR/incident.log"

mkdir -p "$LOG_DIR"

echo "============================" >> "$LOG_FILE"
echo "Incident check ran at: $(date)" >> "$LOG_FILE"

DISK_THRESHOLD=80

DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

if [[ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]]
then
	echo "WARNING:Disk usage is ${DISK_USAGE}% >= ${DISK_THRESHOLD}%" >> "$LOG_FILE"
	echo "Impact: Logs/services may fail due to disk pressure" >>  "$LOG_FILE"
else
	echo " OK: Disk usage is ${DISK_USAGE}%" >> "$LOG_FILE"
fi
