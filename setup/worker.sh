#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname "${0}")/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname "${0}")/setup.env"

# Set CA certificate hash parameter.
[ -n "${ca_cert_hash}" ] && ca_cert_hash="--discovery-token-ca-cert-hash ${ca_cert_hash}" || ca_cert_hash="--discovery-token-unsafe-skip-ca-verification"

# Join cluster.
kubeadm join "${apiserver_fqdn}:6443" --token "${token}" ${ca_cert_hash}
