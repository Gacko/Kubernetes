#!/bin/bash
# Create .kube directory.
mkdir -pm 700 "$HOME/.kube"

# Copy admin.conf to config.
cp /etc/kubernetes/admin.conf "$HOME/.kube/config"

# Fix permissions.
chmod 600 "$HOME/.kube/config"
