#!/bin/bash
# Define version.
VERSION="19.03.4"

# Add repository.
cp "$(dirname "$0")/docker.repo" /etc/yum.repos.d/docker.repo

# Install packages.
yum install --assumeyes "docker-ce-$VERSION" "docker-ce-cli-$VERSION"

# Create configuration directory.
mkdir -p /etc/docker

# Copy configuration.
cp "$(dirname "$0")/daemon.json" /etc/docker/daemon.json

# Remove old drop-ins.
rm -rf /etc/systemd/system/docker.service.d

# Check for existence of docker.service.d.
if [ -d "$(dirname "$0")/docker.service.d" ]
then
  # Copy new drop-ins.
  cp -r "$(dirname "$0")/docker.service.d" /etc/systemd/system/docker.service.d
fi

# Reload daemons.
systemctl daemon-reload

# Enable and start service.
systemctl enable docker
systemctl start docker
