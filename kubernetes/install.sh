#!/bin/bash
# Define version.
VERSION="1.15.1"

# Add repository.
cp "$(dirname "$0")/kubernetes.repo" /etc/yum.repos.d/kubernetes.repo

# Enable bridge-nf-call-iptables.
cp "$(dirname "$0")/bridge-nf-call-iptables.conf" /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system

# Install packages.
yum install --assumeyes "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION"

# Enable service.
systemctl enable kubelet
