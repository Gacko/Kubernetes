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
