#!/bin/bash
kubectl taint node `hostname` node-role.kubernetes.io/master-
kubectl label node `hostname` node-role.kubernetes.io/master-
