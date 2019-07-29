#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname "$0")/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname "$0")/setup.env"

# Define init file.
INIT="$(dirname "$0")/init.yaml"

# Copy init template.
cp "$INIT.template" "$INIT"

# Replace variables.
sed -i.bak "s~APISERVER_FQDN~$APISERVER_FQDN~g" "$INIT"
sed -i.bak "s~POD_CIDR~$POD_CIDR~g" "$INIT"
sed -i.bak "s~SERVICE_CIDR~$SERVICE_CIDR~g" "$INIT"

# Init cluster.
kubeadm init --config "$INIT"

# Remove init backup.
rm -f "$INIT.bak"

# Copy config.
$(dirname "$0")/config.sh

# Define flannel file.
FLANNEL="$(dirname "$0")/flannel.yaml"

# Copy flannel template.
cp "$FLANNEL.template" "$FLANNEL"

# Replace variables.
sed -i.bak "s~POD_CIDR~$POD_CIDR~g" "$FLANNEL"

# Apply flannel.
kubectl apply -f "$FLANNEL"

# Remove flannel backup.
rm -f "$FLANNEL.bak"
