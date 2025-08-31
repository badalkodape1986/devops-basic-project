#!/bin/bash
SERVICE=$1

if [ -z "$SERVICE" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi

if systemctl is-active --quiet $SERVICE; then
  echo "✅ $SERVICE is running"
else
  echo "⚠️ $SERVICE is not running, restarting..."
  sudo systemctl start $SERVICE
  if systemctl is-active --quiet $SERVICE; then
    echo "✅ $SERVICE restarted successfully"
  else
    echo "❌ Failed to restart $SERVICE"
  fi
fi
