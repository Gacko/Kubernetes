#!/bin/bash
# Reset cluster.
kubeadm reset --force

# Remove .kube directory.
rm -rf "${HOME}/.kube"
