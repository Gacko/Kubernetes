#!/bin/bash
# Stop and disable service.
systemctl stop kubelet
systemctl disable kubelet

# Remove bash completion.
rm -f /etc/bash_completion.d/kubectl

# Delete version locks.
yum versionlock delete kubelet kubeadm kubectl

# Remove packages.
yum autoremove --assumeyes kubelet kubeadm kubectl
yum autoremove --assumeyes

# Remove repository.
rm -f /etc/yum.repos.d/kubernetes.repo

# Remove config and data.
rm -rf /etc/kubernetes /usr/libexec/kubernetes /usr/lib/systemd/system/kubelet.service.d /var/lib/dockershim /var/lib/etcd/* /var/lib/kubelet /var/log/pods
