#!/bin/bash
DOCKER_VERSION=1.12.6

# Add repository.
cat << 'EOF' > /etc/yum.repos.d/docker.repo
[docker]
name=Docker
baseurl=https://download.docker.com/linux/centos/7/$basearch/stable
gpgkey=https://download.docker.com/linux/centos/gpg
EOF

# Install package.
yum install --assumeyes docker-$DOCKER_VERSION

# Enable and start.
systemctl enable docker
systemctl start docker
