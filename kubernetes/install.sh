#!/bin/bash
# Define version.
VERSION="1.20.2"

# Enable bridge-nf-call-iptables.
cp "$(dirname "$0")/bridge-nf-call-iptables.conf" /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system

# Add repository.
cp "$(dirname "$0")/kubernetes.repo" /etc/yum.repos.d/kubernetes.repo

# Install packages.
yum install --assumeyes "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION"

# Enable service.
systemctl enable kubelet
