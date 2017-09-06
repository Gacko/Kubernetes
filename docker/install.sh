#!/bin/bash
# Define version.
VERSION="1.12.6"

# Check for existence of docker.service.d.
if [ ! -d "$(dirname $0)/docker.service.d" ]
then
  echo "docker.service.d not found. Copy and configure from docker.service.d.template."
  exit 1
fi

# Install package.
yum install --assumeyes "docker-$VERSION"

# Add version lock.
yum versionlock add "docker-$VERSION"

# Remove old drop-ins.
rm -rf /etc/systemd/system/docker.service.d

# Copy new drop-ins.
cp -r "$(dirname $0)/docker.service.d" /etc/systemd/system/docker.service.d

# Reload daemons.
systemctl daemon-reload

# Enable and start service.
systemctl enable docker
systemctl start docker
