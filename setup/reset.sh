#!/bin/bash
# Reset cluster.
kubeadm reset

# Remove .kube directory.
rm -rf "$HOME/.kube"

# Remove drop-in.
rm -f /etc/systemd/system/kubelet.service.d/90-cluster-dns.conf

# Reload daemons.
systemctl daemon-reload

# Stop service.
systemctl stop kubelet
