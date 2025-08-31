#!/bin/bash
LOGFILE="system_usage.log"

echo "⏱️ $(date)" >> $LOGFILE
echo "CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%" >> $LOGFILE
echo "Memory: $(free -m | awk 'NR==2{printf \"%.2f%%\", $3*100/$2 }')" >> $LOGFILE
echo "Disk: $(df -h / | awk 'NR==2 {print $5}')" >> $LOGFILE
echo "-----------------------------------" >> $LOGFILE

echo "✅ System usage logged to $LOGFILE"
