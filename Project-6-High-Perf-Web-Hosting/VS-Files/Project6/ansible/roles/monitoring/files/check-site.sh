#!/bin/bash
# Script to check HTTP status and response time for each site
# Logs to /var/log/site_checks.log

SITES=(
	"http://localhost"
	"http://127.0.0.1"
	# Add more sites as needed, e.g. "http://customer1.example.com"
)

LOGFILE="/var/log/site_checks.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

for SITE in "${SITES[@]}"; do
	RESULT=$(curl -o /dev/null -s -w "%{http_code} %{time_total}" "$SITE")
	STATUS=$(echo $RESULT | awk '{print $1}')
	TIME=$(echo $RESULT | awk '{print $2}')
	echo "$DATE | $SITE | status: $STATUS | response_time: ${TIME}s" >> "$LOGFILE"
done
