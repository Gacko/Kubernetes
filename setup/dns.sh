#!/bin/bash
# Define service CIDR.
SERVICE_CIDR="$1"

# Build cluster DNS address.
SERVICE_IP="${SERVICE_CIDR%\/*}"
CLUSTER_DNS="${SERVICE_IP%\.*}.$((${SERVICE_IP##*\.}+10))"

# Define drop-in file.
DROPIN="$(dirname "$0")/cluster-dns.conf"

# Copy drop-in template.
cp "$DROPIN.template" "$DROPIN"

# Replace variables.
sed -i.bak "s~CLUSTER_DNS~$CLUSTER_DNS~g" "$DROPIN"

# Install drop-in.
cp "$DROPIN" /etc/systemd/system/kubelet.service.d/90-cluster-dns.conf

# Reload daemons.
systemctl daemon-reload

# Remove drop-in files.
rm -f "$DROPIN" "$DROPIN.bak"
