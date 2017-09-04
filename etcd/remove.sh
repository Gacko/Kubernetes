#!/bin/bash
# Stop and disable service.
systemctl stop etcd
systemctl disable etcd

# Remove service.
rm -f /etc/systemd/system/etcd.service

# Reload daemons.
systemctl daemon-reload

# Remove data.
rm -rf /var/lib/etcd/*
