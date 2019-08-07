#!/bin/bash
# Delete resources.
kubectl delete -f "$(dirname "$0")"
