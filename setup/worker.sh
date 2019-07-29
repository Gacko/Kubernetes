#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname "$0")/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname "$0")/setup.env"

# Set CA certificate hash parameter.
[ -n "$CA_CERT_HASH" ] && CA_CERT_HASH="--discovery-token-ca-cert-hash $CA_CERT_HASH" || CA_CERT_HASH="--discovery-token-unsafe-skip-ca-verification"

# Join cluster.
kubeadm join "$APISERVER_FQDN:6443" --token "$TOKEN" $CA_CERT_HASH
