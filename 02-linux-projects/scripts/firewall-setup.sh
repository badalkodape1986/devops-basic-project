#!/bin/bash
set -e

echo "🔒 Setting up firewall rules..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

echo "✅ Firewall configured (SSH, HTTP, HTTPS allowed)"
