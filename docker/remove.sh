#!/bin/bash
DOCKER_VERSION=1.12.6

systemctl stop docker
systemctl disable docker

yum install --assumeyes docker-$DOCKER_VERSION

rm -rf /etc/yum.repos.d/docker.repo /var/lib/docker
