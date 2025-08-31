#!/bin/bash
THRESHOLD=50

echo "🔎 Checking for processes above ${THRESHOLD}% CPU usage..."
ps -eo pid,comm,%cpu --sort=-%cpu | awk -v th=$THRESHOLD '$3 > th {print $1, $2, $3}' | while read pid cmd cpu; do
  echo "⚠️ Killing $cmd (PID $pid) using $cpu% CPU"
  sudo kill -9 $pid
done

echo "✅ Cleanup complete"
