# Dokku

> <https://www.ledokku.com/docs/getting-started/>
> <https://dokku.com/docs/getting-started/install/vagrant/>

Dokku is open source PaaS (Platform as a service) to deploy containers in the server like Heroku

## Purpose

This lab will simulate k8s cluster and create 2 pods with service type load balancer redirect traffic to pods.

## Getting Started

### Provision lab by Terraform

```sh
cd (to this lab path)
terraform init
terraform apply
```

This will create kind cluster, 2 pods and service type load balancer.

### Test

Get the load balance ip and try to get them.

```sh
LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

for _ in {1..10}; do
  curl ${LB_IP}:5678
done
```

You would see different response from 2 pod in cluster.

## Problem

If you can't reachable to loadbalancer ip, read the quote from Kind document.

```txt
With Docker on Linux, you can send traffic directly to the loadbalancer's external IP if the IP space is within the docker IP space.

On macOS and Windows, docker does not expose the docker network to the host. Because of this limitation, containers (including kind nodes) are only reachable from the host via port-forwards, however other containers/pods can reach other things running in docker including loadbalancers. You may want to check out the Ingress Guide as a cross-platform workaround. You can also expose pods and services using extra port mappings as shown in the extra port mappings section of the Configuration Guide.
```

## Cleanup

```sh
terraform destroy
```

## Reference

- [Kind LoadBalancer Guide](https://kind.sigs.k8s.io/docs/user/loadbalancer/)
- [Kubernetes Service Type LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer)
