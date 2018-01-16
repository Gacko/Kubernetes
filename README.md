# Kubernetes

These scripts are separated into stages (folders) and tasks (scripts).

To execute a task, simply run `kube.sh` with stage, task and a list of hosts:

```
./kube.sh stage task host-1 ...
```

## Base

Base packages need to be installed on all nodes:

```
./kube.sh base install node-1 ...
```

To remove base packages, run:

```
./kube.sh base remove node-1 ...
```

## Docker

Copy `docker.service.d.template` to `docker.service.d` inside of `docker` and configure the included files according to your needs.

Docker needs to be installed on all nodes:

```
./kube.sh docker install node-1 ...
```

To remove Docker, run:

```
./kube.sh docker remove node-1 ...
```

## etcd

Copy `etcd.env.template` to `etcd.env` inside of `etcd` and configure it according to your needs.

etcd can be installed on dedicated nodes or master nodes:

```
./kube.sh etcd install etcd-1 ...
```

To remove etcd, run:

```
./kube.sh etcd remove etcd-1 ...
```

## Kubernetes

Kubernetes packages need to be installed on all nodes:

```
./kube.sh kubernetes install node-1 ...
```

To remove Kubernetes packages, run:

```
./kube.sh kubernetes remove node-1 ...
```

## Setup

Copy `setup.env.template` to `setup.env` inside of `setup` and configure it according to your needs.

Initialize your cluster on the first master:

```
./kube.sh setup master master-1
```

Transfer configuration files from first master to other masters:

```
./transfer.sh master-1 master-2 ...
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

## Uninstall

To return to a specific stage execute the steps decribed above in inverse order using the reset / remove tasks.
