#!/bin/bash
# Check for existence of master.yml.
if [ ! -f `dirname $0`/master.yml ]
then
  echo "master.yml not found. Copy and configure from master-template.yml."
  exit 1
fi

# Check for existence of flannel/flannel-configmap.yml.
if [ ! -f `dirname $0`/flannel/flannel-configmap.yml ]
then
  echo "flannel/flannel-configmap.yml not found. Copy and configure from flannel/flannel-configmap-template.yml."
  exit 1
fi

# Init cluster.
kubeadm init --config `dirname $0`/master.yml

# Create .kube directory.
mkdir -p $HOME/.kube

# Fix permissions.
chmod 700 $HOME/.kube

# Copy admin.conf to config.
cp /etc/kubernetes/admin.conf $HOME/.kube/config

# Fix permissions.
chmod 600 $HOME/.kube/config

# Apply flannel.
kubectl apply -f `dirname $0`/flannel/flannel-rbac.yml
kubectl apply -f `dirname $0`/flannel/flannel-configmap.yml
kubectl apply -f `dirname $0`/flannel/flannel.yml
