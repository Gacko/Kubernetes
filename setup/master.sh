#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname "$0")/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname "$0")/setup.env"

# Override cluster DNS.
$(dirname "$0")/dns.sh "$SERVICE_CIDR"

# Check for existence of kubelet.conf.
if [ ! -f "/etc/kubernetes/kubelet.conf" ]
then
  echo "kubelet.conf not found. Transfer /etc/kubernetes from first node."
  exit 1
fi

# Replace hostname.
sed -i.bak "s~system:node:.*~system:node:$HOSTNAME~g" /etc/kubernetes/kubelet.conf

# Remove backup.
rm -f /etc/kubernetes/kubelet.conf.bak

# Start service.
systemctl start kubelet

# Wait for startup.
sleep 10

# Copy config.
$(dirname "$0")/config.sh

# Taint node.
kubectl taint node "$HOSTNAME" node-role.kubernetes.io/master=:NoSchedule
kubectl label node "$HOSTNAME" node-role.kubernetes.io/master=
