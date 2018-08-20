#!/bin/bash
kubectl taint node "$HOSTNAME" node-role.kubernetes.io/master-
