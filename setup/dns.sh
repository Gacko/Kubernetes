#!/bin/bash
# Define service CIDR.
SERVICE_CIDR="$1"

# Build cluster DNS address.
SERVICE_IP="${SERVICE_CIDR%\/*}"
CLUSTER_DNS="${SERVICE_IP%\.*}.$((${SERVICE_IP##*\.}+10))"

# Override cluster DNS.
cat << EOF > /etc/systemd/system/kubelet.service.d/90-cluster-dns.conf
[Service]
Environment="KUBELET_DNS_ARGS=--cluster-dns=$CLUSTER_DNS --cluster-domain=cluster.local"
EOF

# Reload daemons.
systemctl daemon-reload
