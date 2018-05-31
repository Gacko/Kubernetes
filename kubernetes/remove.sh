#!/bin/bash
# Stop and disable service.
systemctl stop kubelet
systemctl disable kubelet

# Remove bash completion.
rm -f /etc/bash_completion.d/kubectl

# Delete version locks.
yum versionlock delete kubelet kubeadm kubectl kubernetes-cni

# Remove packages.
yum autoremove --assumeyes kubelet kubeadm kubectl kubernetes-cni
yum autoremove --assumeyes

# Remove drop-ins.
rm -rf /etc/systemd/system/kubelet.service.d

# Reload daemons.
systemctl daemon-reload

# Disable bridge-nf-call-iptables.
rm -f /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system

# Remove repository.
rm -f /etc/yum.repos.d/kubernetes.repo

# Remove config and data.
rm -rf /etc/kubernetes /usr/libexec/kubernetes /var/lib/kubelet /var/lib/dockershim
