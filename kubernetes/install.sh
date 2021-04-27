#!/bin/bash
# Define version.
version="1.20.6"

# Enable bridge-nf-call-iptables.
cp "$(dirname "${0}")/bridge-nf-call-iptables.conf" /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system

# Add repository.
cp "$(dirname "${0}")/kubernetes.repo" /etc/yum.repos.d/kubernetes.repo

# Install packages.
yum install --assumeyes "kubelet-${version}" "kubeadm-${version}" "kubectl-${version}"

# Enable service.
systemctl enable kubelet
