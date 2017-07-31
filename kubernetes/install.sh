#!/bin/bash
# Define version.
KUBERNETES_VERSION=1.6.7

# Add repository.
cat << 'EOF' > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
repo_gpgcheck=1
EOF

# Install packages.
yum install --assumeyes kubelet-$KUBERNETES_VERSION kubeadm-$KUBERNETES_VERSION kubectl-$KUBERNETES_VERSION bash-completion

# Install bash completion.
kubectl completion bash > /etc/bash_completion.d/kubectl

# Enable and start.
systemctl enable kubelet
systemctl start kubelet
