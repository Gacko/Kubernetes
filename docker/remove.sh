#!/bin/bash
# Stop and disable.
systemctl stop docker
systemctl disable docker

# Remove package.
yum remove --assumeyes docker

# Remove repository and files.
rm -rf /etc/yum.repos.d/docker.repo /var/lib/docker
