# Kubernetes

These scripts are separated into stages (folders) and tasks (scripts).

To execute a task, simply run `kube.sh` with stage, task and a list of hosts:

```
./kube.sh stage task host-1 ...
```

## Docker

Copy `docker.service.d.template` to `docker.service.d` inside of `docker` and configure it according to your needs.

Docker needs to be installed on all nodes:

```
./kube.sh docker install node-1 ...
```

To remove Docker, run:

```
./kube.sh docker remove node-1 ...
```

## Kubernetes

Kubernetes needs to be installed on all nodes:

```
./kube.sh kubernetes install node-1 ...
```

To remove Kubernetes, run:

```
./kube.sh kubernetes remove node-1 ...
```

## Setup

Copy `setup.env.template` to `setup.env` inside of `setup` and configure it according to your needs.

CA certificate hash will be generated during master setup.

Initialize your cluster on the first master:

```
./kube.sh setup init master-1
```

Join other masters:

```
./kube.sh setup master master-2 ...
```

Join workers:

```
./kube.sh setup worker worker-1 ...
```

To reset a node, run:

```
./kube.sh setup reset node-1 ...
```

## Deploy

Apply example resources to your cluster:

```
./kube.sh deploy apply master-1
```

Delete example resources from your cluster:

```
./kube.sh deploy delete master-1
```

## Uninstall

To return to a specific stage execute the steps described above in inverse order using the delete / reset / remove tasks.
