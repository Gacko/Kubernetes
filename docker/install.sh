#!/bin/bash
DOCKER_VERSION=1.12.6

cat << 'EOF' > /etc/yum.repos.d/docker.repo
[docker]
name=Docker CE Stable - $basearch
baseurl=https://download.docker.com/linux/centos/7/$basearch/stable
gpgkey=https://download.docker.com/linux/centos/gpg
EOF

yum install --assumeyes docker-$DOCKER_VERSION

systemctl enable docker
systemctl start docker
