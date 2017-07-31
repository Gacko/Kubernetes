#!/bin/bash
kubectl taint node kube-master node-role.kubernetes.io/master=:NoSchedule
kubectl label node kube-master node-role.kubernetes.io/master=
