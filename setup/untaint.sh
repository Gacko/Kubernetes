#!/bin/bash
# Untaint node.
kubectl taint node "${HOSTNAME}" node-role.kubernetes.io/master-
