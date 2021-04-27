#!/bin/bash
# Check for existence of setup.env.
if [ ! -f "$(dirname "${0}")/setup.env" ]
then
  echo "setup.env not found. Copy and configure from setup.env.template."
  exit 1
fi

# Source environment.
source "$(dirname "${0}")/setup.env"

# Define init file.
init="$(dirname "${0}")/init.yaml"

# Copy init template.
cp "${init}.template" "${init}"

# Replace variables.
sed -i.bak "s~VERSION~${version}~g" "${init}"
sed -i.bak "s~APISERVER_FQDN~${apiserver_fqdn}~g" "${init}"
sed -i.bak "s~POD_CIDR~${pod_cidr}~g" "${init}"
sed -i.bak "s~SERVICE_CIDR~${service_cidr}~g" "${init}"
sed -i.bak "s~TOKEN~${token}~g" "${init}"
sed -i.bak "s~CERTIFICATE_KEY~${certificate_key}~g" "${init}"

# Init cluster.
kubeadm init --config "${init}" --upload-certs

# Remove init backup.
rm -f "${init}.bak"

# Copy config.
$(dirname "${0}")/config.sh

# Define flannel and ingress file.
flannel="$(dirname "${0}")/flannel.yaml"
ingress="$(dirname "${0}")/ingress.yaml"

# Copy flannel template.
cp "${flannel}.template" "${flannel}"

# Replace variables.
sed -i.bak "s~POD_CIDR~${pod_cidr}~g" "${flannel}"

# Apply flannel and ingress.
kubectl apply -f "${flannel}" -f "${ingress}"

# Remove flannel backup.
rm -f "${flannel}.bak"
