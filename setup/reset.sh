#!/bin/bash
# Reset cluster.
kubeadm reset

# Remove .kube directory.
rm -rf $HOME/.kube
