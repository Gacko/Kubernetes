#!/bin/bash
# Define version.
VERSION="v3.0.17"

# Check for existence of etcd.env.
if [ ! -f "$(dirname $0)/etcd.env" ]
then
  echo "etcd.env not found. Copy and configure from etcd.env.template."
  exit 1
fi

# Source environment.
source "$(dirname $0)/etcd.env"

# Build cluster string.
CLUSTER=""
for node in $NODES
do
  if [ -z "$CLUSTER" ]
  then
    CLUSTER="$node=http://$node:2380"
  else
    CLUSTER="$CLUSTER,$node=http://$node:2380"
  fi
done

# Define service file.
SERVICE="$(dirname $0)/etcd.service"

# Copy service template.
cp "$SERVICE.template" "$SERVICE"

# Replace variables.
sed -i.bak "s~VERSION~$VERSION~g" "$SERVICE"
sed -i.bak "s~HOSTNAME~$HOSTNAME~g" "$SERVICE"
sed -i.bak "s~CLUSTER~$CLUSTER~g" "$SERVICE"
sed -i.bak "s~TOKEN~$TOKEN~g" "$SERVICE"

# Install service.
cp "$SERVICE" /etc/systemd/system/etcd.service

# Reload daemons.
systemctl daemon-reload

# Remove service files.
rm -f "$SERVICE" "$SERVICE.bak"

# Enable and start service.
systemctl enable etcd
systemctl start etcd
