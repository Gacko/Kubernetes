#!/bin/bash
kubectl taint node "$HOSTNAME" node-role.kubernetes.io/master-
kubectl label node "$HOSTNAME" node-role.kubernetes.io/master-
