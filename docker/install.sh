#!/bin/bash
# Define version.
version="19.03.11"

# Check distribution.
if [ -f /etc/oracle-release ]
then
  # Enable repository.
  yum-config-manager --enable ol7_addons

  # Install packages.
  yum install --assumeyes "docker-engine-${version}.ol" "docker-cli-${version}.ol"
else
  # Add repository.
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

  # Install packages.
  yum install --assumeyes "docker-ce-${version}" "docker-ce-cli-${version}"
fi

# Create configuration directory.
mkdir -p /etc/docker

# Copy configuration.
cp "$(dirname "${0}")/daemon.json" /etc/docker/daemon.json

# Remove old drop-ins.
rm -rf /etc/systemd/system/docker.service.d

# Check for existence of docker.service.d.
if [ -d "$(dirname "${0}")/docker.service.d" ]
then
  # Copy new drop-ins.
  cp -r "$(dirname "${0}")/docker.service.d" /etc/systemd/system/docker.service.d
fi

# Reload daemons.
systemctl daemon-reload

# Enable and start service.
systemctl enable docker
systemctl start docker
