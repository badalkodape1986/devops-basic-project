#!/bin/bash
set -e

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing common tools..."
sudo apt install -y git curl wget htop unzip

echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo usermod -aG docker $USER

echo "🌐 Installing Nginx..."
sudo apt install -y nginx
sudo systemctl enable nginx

echo "✅ Server setup complete!"
