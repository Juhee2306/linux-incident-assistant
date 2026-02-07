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
	echo "OK: Disk usage is ${DISK_USAGE}%" >> "$LOG_FILE"
fi

MEM_THRESHOLD=80
MEMORY_TOTAL=$(free | awk '/Mem:/ {print $2}')
MEMORY_USED=$(free| awk '/Mem:/ {print $3}')
MEM_PER=$(( MEMORY_USED * 100 /MEMORY_TOTAL ))

if [[ "$MEM_PER" -ge "$MEM_THRESHOLD" ]]
then
	echo "WARNING: Memory usage is ${MEM_PER}% >= ${MEM_THRESHOLD}%" >> $LOG_FILE
	echo "Impact: Processes may slow down or get killed due to memory pressure" >> $LOG_FILE
else
	echo "OK: Memory usage is ${MEM_PER}%" >> $LOG_FILE
fi

