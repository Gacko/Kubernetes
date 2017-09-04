#!/bin/bash
# Stop and disable service.
systemctl stop docker
systemctl disable docker

# Remove drop-ins.
rm -rf /etc/systemd/system/docker.service.d

# Reload daemons.
systemctl daemon-reload

# Delete version lock.
yum versionlock delete docker

# Remove package.
yum autoremove --assumeyes docker
yum autoremove --assumeyes

# Remove repository
rm -f /etc/yum.repos.d/docker.repo

# Remove config and data.
rm -rf /etc/docker /var/lib/docker/* /var/lib/systemd/timers/stamp-docker-cleanup.timer /usr/libexec/docker
