#!/bin/bash
# Define version.
VERSION="1.6.7"

# Add repository.
cat << 'EOF' > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
repo_gpgcheck=1
EOF

# Enable bridge-nf-call-iptables.
cat << 'EOF' > /etc/sysctl.d/90-bridge-nf-call-iptables.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Reload sysctl.
sysctl --system

# Install packages.
yum install --assumeyes "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION"

# Add version locks.
yum versionlock add "kubelet-$VERSION" "kubeadm-$VERSION" "kubectl-$VERSION"

# Install bash completion.
kubectl completion bash > /etc/bash_completion.d/kubectl

# Enable service.
systemctl enable kubelet
