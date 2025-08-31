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
