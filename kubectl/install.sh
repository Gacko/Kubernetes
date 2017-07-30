#!/bin/bash
KUBECTL_VERSION=1.6.6

# Download kubectl.
curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl

# Fix permissions.
chmod +x /usr/local/bin/kubectl
