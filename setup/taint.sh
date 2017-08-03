#!/bin/bash
kubectl taint node `hostname` node-role.kubernetes.io/master=:NoSchedule
kubectl label node `hostname` node-role.kubernetes.io/master=
