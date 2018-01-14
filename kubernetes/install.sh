#!/bin/bash
# Define version.
VERSION="1.8.2"

# Add repository.
cp "$(dirname "$0")/kubernetes.repo" /etc/yum.repos.d/kubernetes.repo

# Enable bridge-nf-call-iptables.
cp "$(dirname "$0")/bridge-nf-call-iptables.conf" /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system

# Install packages.
yum install --assumeyes "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION" kubernetes-cni-0.5.1

# Add version locks.
yum versionlock add "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION" kubernetes-cni-0.5.1

# Install bash completion.
kubectl completion bash > /etc/bash_completion.d/kubectl

# Enable service.
systemctl enable kubelet
