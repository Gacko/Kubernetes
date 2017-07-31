#!/bin/bash
kubectl taint node kube-master node-role.kubernetes.io/master-
kubectl label node kube-master node-role.kubernetes.io/master-
