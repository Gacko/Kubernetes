#!/bin/bash
# Stop and disable service.
systemctl stop docker
systemctl disable docker

# Remove drop-ins.
rm -rf /etc/systemd/system/docker.service.d

# Reload daemons.
systemctl daemon-reload

# Remove packages.
yum autoremove --assumeyes docker docker-client docker-common
yum autoremove --assumeyes

# Remove config and data.
rm -rf /etc/docker /etc/sysconfig/docker* /var/lib/docker/* /var/lib/systemd/timers/stamp-docker-cleanup.timer
