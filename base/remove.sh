#!/bin/bash
# Remove packages.
yum autoremove --assumeyes yum-plugin-versionlock nfs-utils bash-completion
yum autoremove --assumeyes
