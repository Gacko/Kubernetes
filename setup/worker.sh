#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname "$0")/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname "$0")/setup.env"

# Override cluster DNS.
$(dirname "$0")/dns.sh "$SERVICE_CIDR"

# Join cluster.
kubeadm join --token "$TOKEN" "$APISERVER_FQDN:6443" --discovery-token-unsafe-skip-ca-verification
