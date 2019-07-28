#!/bin/bash
# Stop and disable service.
systemctl stop kubelet
systemctl disable kubelet

# Remove packages.
yum autoremove --assumeyes kubelet kubeadm kubectl
yum autoremove --assumeyes

# Disable bridge-nf-call-iptables.
rm -f /etc/sysctl.d/90-bridge-nf-call-iptables.conf

# Reload sysctl.
sysctl --system

# Remove repository.
rm -f /etc/yum.repos.d/kubernetes.repo

# Remove config and data.
rm -rf /etc/kubernetes /usr/libexec/kubernetes /usr/lib/systemd/system/kubelet.service.d /var/lib/dockershim /var/lib/etcd/* /var/lib/kubelet /var/log/pods
