#!/bin/bash
# Define version.
VERSION="1.15.1"

# Enable bridge-nf-call-iptables.
cp "$(dirname "$0")/bridge-nf-call-iptables.conf" /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system

# Add repository.
cp "$(dirname "$0")/kubernetes.repo" /etc/yum.repos.d/kubernetes.repo

# Install packages.
yum install --assumeyes "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION"

# Remove old drop-ins.
rm -rf /etc/systemd/system/kubelet.service.d

# Copy new drop-ins.
cp -r "$(dirname "$0")/kubelet.service.d" /etc/systemd/system/kubelet.service.d

# Reload daemons.
systemctl daemon-reload

# Enable service.
systemctl enable kubelet
