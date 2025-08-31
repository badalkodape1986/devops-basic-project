#!/bin/bash
# 🚀 All-in-One Script: Create DevOps Basics (Linux) Projects
# Author: You 😎
# This will create README.md and multiple useful Linux scripts

set -e

# Create base folder
mkdir -p 01-devops-basics/scripts

# Create README.md
cat > 01-devops-basics/README.md <<'EOF'
# DevOps Basics Projects

Beginner-friendly Linux/DevOps automation with Bash scripts.

## 🚀 Projects
1. **Setup Server** – Installs Docker, Git, Nginx automatically.
2. **Backup Script** – Archives important files daily with cron.
3. **System Monitor** – Logs CPU, memory, disk usage.
4. **User Management** – Automates user/group creation.
5. **Firewall Setup** – Configures UFW with secure defaults.
6. **Disk Usage Alert** – Warns when disk usage is > threshold.
7. **Service Health Check** – Restarts services if stopped.
8. **Kill High-CPU Processes** – Cleans runaway processes.

## 📘 Skills Learned
- Linux automation
- Bash scripting
- Security hardening
- Monitoring & troubleshooting
- Self-healing infrastructure
EOF

# --- Scripts ---

# 1. Setup Server
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

# 2. Backup Script
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

# 3. System Monitor
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

# 4. User Management
cat > 01-devops-basics/scripts/user-management.sh <<'EOF'
#!/bin/bash
set -e

if [ $# -lt 2 ]; then
  echo "Usage: $0 <username> <group>"
  exit 1
fi

USERNAME=$1
GROUP=$2

if ! getent group $GROUP >/dev/null; then
  sudo groupadd $GROUP
  echo "✅ Group $GROUP created"
fi

if id "$USERNAME" &>/dev/null; then
  echo "⚠️ User $USERNAME already exists"
else
  sudo useradd -m -s /bin/bash -g $GROUP $USERNAME
  echo "✅ User $USERNAME created and added to group $GROUP"
fi
EOF
chmod +x 01-devops-basics/scripts/user-management.sh

# 5. Firewall Setup
cat > 01-devops-basics/scripts/firewall-setup.sh <<'EOF'
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
EOF
chmod +x 01-devops-basics/scripts/firewall-setup.sh

# 6. Disk Alert
cat > 01-devops-basics/scripts/disk-alert.sh <<'EOF'
#!/bin/bash
THRESHOLD=80
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ $USAGE -gt $THRESHOLD ]; then
  echo "⚠️ Disk usage is at ${USAGE}% (threshold ${THRESHOLD}%)"
else
  echo "✅ Disk usage is normal: ${USAGE}%"
fi
EOF
chmod +x 01-devops-basics/scripts/disk-alert.sh

# 7. Service Check
cat > 01-devops-basics/scripts/service-check.sh <<'EOF'
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
EOF
chmod +x 01-devops-basics/scripts/service-check.sh

# 8. Kill High-CPU Processes
cat > 01-devops-basics/scripts/kill-high-cpu.sh <<'EOF'
#!/bin/bash
THRESHOLD=50

echo "🔎 Checking for processes above ${THRESHOLD}% CPU usage..."
ps -eo pid,comm,%cpu --sort=-%cpu | awk -v th=$THRESHOLD '$3 > th {print $1, $2, $3}' | while read pid cmd cpu; do
  echo "⚠️ Killing $cmd (PID $pid) using $cpu% CPU"
  sudo kill -9 $pid
done

echo "✅ Cleanup complete"
EOF
chmod +x 01-devops-basics/scripts/kill-high-cpu.sh

echo "🎉 DevOps Basics Linux projects created successfully!"
echo "📂 Folder: 01-devops-basics/"

