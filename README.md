# Kubernetes
Several deployment scripts.

## Docker
You can create a directory ```docker.service.d``` inside of ```docker``` and put your systemd drop-ins there. This directory is optional.

## Setup
Copy ```master-template.yml``` to ```master.yml``` and ```flannel/flannel-configmap-template.yml``` to ```flannel/flannel-configmap.yml``` inside of ```setup``` and configure them according to your needs.
