#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname $0)/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname $0)/setup.env"

# Override cluster DNS.
$(dirname "$0")/dns.sh "$SERVICE_CIDR"

# Lookup API server IP.
APISERVER_IP="$(getent hosts "$APISERVER_FQDN" | awk '{print $1}')"

# Build etcd cluster string.
ETCD_CLUSTER=""
for node in $ETCD_NODES
do
  if [ -z "$ETCD_CLUSTER" ]
  then
    ETCD_CLUSTER="\"http://$node:2379\""
  else
    ETCD_CLUSTER="$ETCD_CLUSTER, \"http://$node:2379\""
  fi
done
ETCD_CLUSTER="[ $ETCD_CLUSTER ]"

# Define master file.
MASTER="$(dirname $0)/master.yml"

# Copy master template.
cp "$MASTER.template" "$MASTER"

# Replace variables.
sed -i.bak "s~APISERVER_FQDN~$APISERVER_FQDN~g" "$MASTER"
sed -i.bak "s~APISERVER_IP~$APISERVER_IP~g" "$MASTER"
sed -i.bak "s~ETCD_CLUSTER~$ETCD_CLUSTER~g" "$MASTER"
sed -i.bak "s~TOKEN~$TOKEN~g" "$MASTER"
sed -i.bak "s~POD_CIDR~$POD_CIDR~g" "$MASTER"
sed -i.bak "s~SERVICE_CIDR~$SERVICE_CIDR~g" "$MASTER"

# Init cluster.
kubeadm init --config "$MASTER"

# Remove master files.
rm -f "$MASTER" "$MASTER.bak"

# Copy config.
$(dirname "$0")/config.sh

# Define flannel file.
FLANNEL="$(dirname $0)/flannel/flannel-configmap.yml"

# Copy flannel template.
cp "$FLANNEL.template" "$FLANNEL"

# Replace variables.
sed -i.bak "s~POD_CIDR~$POD_CIDR~g" "$FLANNEL"

# Apply flannel.
kubectl apply -f "$(dirname $0)/flannel/flannel-rbac.yml"
kubectl apply -f "$FLANNEL"
kubectl apply -f "$(dirname $0)/flannel/flannel.yml"

# Remove flannel files.
rm -f "$FLANNEL" "$FLANNEL.bak"
