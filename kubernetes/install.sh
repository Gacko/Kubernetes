#!/bin/bash
# Define version.
VERSION="1.15.1"

# Add repository.
cp "$(dirname "$0")/kubernetes.repo" /etc/yum.repos.d/kubernetes.repo

# Install packages.
yum install --assumeyes "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION"

# Enable service.
systemctl enable kubelet
