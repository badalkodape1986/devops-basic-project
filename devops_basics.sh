#!/bin/bash
# 🚀 Script to create DevOps Basics project with README & scripts

set -e

# Create project folder & scripts directory
mkdir -p 01-devops-basics/scripts

# Create README.md
cat > 01-devops-basics/README.md <<'EOF'
# DevOps Basics Projects

This folder contains beginner-friendly DevOps projects automated with Bash.

## 🚀 Projects
1. **Setup Server** – Installs Docker, Git, Nginx automatically.
2. **Backup Script** – Archives important files daily with cron.
3. **System Monitor** – Logs CPU, memory, disk usage.

## 📘 Skills Learned
- Linux automation
- Bash scripting
- Cron jobs
- Monitoring & logging
EOF

# Create setup-server.sh
cat > 01-devops-basics/scripts/setup-server.sh <<'EOF'
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
EOF
chmod +x 01-devops-basics/scripts/setup-server.sh

# Create backup.sh
cat > 01-devops-basics/scripts/backup.sh <<'EOF'
#!/bin/bash
set -e

SOURCE_DIR="/home/$USER/data"
BACKUP_DIR="/home/$USER/backups"
TIMESTAMP=$(date +%F_%H-%M-%S)

mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/data_backup_$TIMESTAMP.tar.gz" "$SOURCE_DIR"

echo "✅ Backup completed: $BACKUP_DIR/data_backup_$TIMESTAMP.tar.gz"
EOF
chmod +x 01-devops-basics/scripts/backup.sh

# Create system-monitor.sh
cat > 01-devops-basics/scripts/system-monitor.sh <<'EOF'
#!/bin/bash
LOGFILE="system_usage.log"

echo "⏱️ $(date)" >> $LOGFILE
echo "CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%" >> $LOGFILE
echo "Memory: $(free -m | awk 'NR==2{printf \"%.2f%%\", $3*100/$2 }')" >> $LOGFILE
echo "Disk: $(df -h / | awk 'NR==2 {print $5}')" >> $LOGFILE
echo "-----------------------------------" >> $LOGFILE

echo "✅ System usage logged to $LOGFILE"
EOF
chmod +x 01-devops-basics/scripts/system-monitor.sh

echo "🎉 DevOps Basics project created successfully!"
echo "📂 Folder: 01-devops-basics/"

