#!/bin/bash
# Stop and disable.
systemctl stop kubelet
systemctl disable kubelet

# Remove bash completion.
rm -f /etc/bash_completion.d/kubectl

# Remove packages.
yum autoremove --assumeyes kubelet kubeadm kubectl bash-completion
yum autoremove --assumeyes

# Remove repository.
rm -f /etc/yum.repos.d/kubernetes.repo

# Disable bridge-nf-call-iptables.
rm -f /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system
