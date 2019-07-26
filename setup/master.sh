#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname "$0")/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname "$0")/setup.env"

# Check for existence of CA certificate hash.
if [ -z "$CA_CERT_HASH" ]
then
  echo "CA certificate hash not found. Configure CA certificate hash in setup.env."
  exit 1
fi

# Join cluster.
kubeadm join --token "$TOKEN" "$APISERVER_FQDN:6443" --discovery-token-ca-cert-hash "$CA_CERT_HASH" --experimental-control-plane

# Copy config.
$(dirname "$0")/config.sh
