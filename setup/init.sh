#!/bin/bash
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
kubectl apply -f `dirname $0`/flannel/flannel.yml
