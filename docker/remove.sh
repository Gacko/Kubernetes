#!/bin/bash
# Stop and disable service.
systemctl stop docker
systemctl disable docker

# Remove drop-ins.
rm -rf /etc/systemd/system/docker.service.d

# Reload daemons.
systemctl daemon-reload

# Remove configuration directory.
rm -rf /etc/docker

# Remove packages.
yum autoremove --assumeyes docker-ce
yum autoremove --assumeyes

# Remove repository.
rm -f /etc/yum.repos.d/docker.repo

# Remove data.
rm -rf /var/lib/docker/*
