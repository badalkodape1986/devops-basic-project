#!/bin/bash
THRESHOLD=80
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ $USAGE -gt $THRESHOLD ]; then
  echo "⚠️ Disk usage is at ${USAGE}% (threshold ${THRESHOLD}%)"
else
  echo "✅ Disk usage is normal: ${USAGE}%"
fi
