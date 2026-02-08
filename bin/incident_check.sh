#!/bin/bash

LOG_DIR="../logs"
LOG_FILE="$LOG_DIR/incident.log"

mkdir -p "$LOG_DIR"

log(){
	echo "$1" >> "$LOG_FILE"
}

disk_check(){
	DISK_THRESHOLD=80
	DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
	if [[ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]]
	then
		log "WARNING:Disk usage is ${DISK_USAGE}% >= ${DISK_THRESHOLD}%"
		log "Impact: Logs/services may fail due to disk pressure"
	else
		log "OK: Disk usage is ${DISK_USAGE}%" 
	fi

}

memory_check(){
	MEM_THRESHOLD=80
	MEMORY_TOTAL=$(free | awk '/Mem:/ {print $2}')
	MEMORY_USED=$(free| awk '/Mem:/ {print $3}')
	MEM_PER=$(( MEMORY_USED * 100 /MEMORY_TOTAL ))
	if [[ "$MEM_PER" -ge "$MEM_THRESHOLD" ]]
	then
		log "WARNING: Memory usage is ${MEM_PER}% >= ${MEM_THRESHOLD}%" 
		log "Impact: Processes may slow down or get killed due to memory pressure" 
	else
		log "OK: Memory usage is ${MEM_PER}%"
	fi

}

ssh_check(){
	if pgrep -x sshd > /dev/null
	then
		log "OK: SSH daemon is running" 
	else
		log "WARNING: SSH daemon is NOT running"
		log "Impact: Remote access to this system is unavailable" 
	fi

}

main(){
	log "============================"
        log "Incident check ran at: $(date)"


	disk_check
	memory_check
	ssh_check

}
main
