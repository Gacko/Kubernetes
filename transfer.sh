#!/bin/bash
# Get first master.
MASTER="$1"
# Shift arguments.
shift

# Remove existing configuration in /tmp.
rm -rf /tmp/kubernetes
# Create empty configuration in /tmp.
mkdir /tmp/kubernetes
# Download configuration from first master.
scp -r "$MASTER:/etc/kubernetes/pki" /tmp/kubernetes/pki

# Transfer configuration to other masters.
for host in $@
do
  # Remove existing configuration on other master.
  ssh "$host" "rm -rf /etc/kubernetes"
  # Transfer configuration to other master.
  scp -r /tmp/kubernetes "$host:/etc/kubernetes"
done

# Remove downloaded configuration from /tmp.
rm -rf /tmp/kubernetes
