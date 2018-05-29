#!/bin/bash
# Install package.
yum install --assumeyes docker docker-client docker-common

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
