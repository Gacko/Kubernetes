#!/bin/bash
# Define version.
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

# Check for existence of docker.service.d.
if [ -d `dirname $0`/docker.service.d ]
then
  # Remove old drop-ins.
  rm -rf /etc/systemd/system/docker.service.d
  # Install new drop-ins.
  cp -r `dirname $0`/docker.service.d /etc/systemd/system/docker.service.d
  # Reload daemons.
  systemctl daemon-reload
fi

# Enable and start.
systemctl enable docker
systemctl start docker
