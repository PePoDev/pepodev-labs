# Ingress Controller

## Purpose

This lab will simulate k8s cluster and apply deployment with nginx ingress controller.

## Getting Started

### Provision lab by Terraform

```sh
cd (to this lab path)
terraform init
terraform apply
```

This will create kind cluster, nginx ingress controller and apply demo app

### Test

```sh
#  Get loadbalance ip and bind it with localhost
kubectl get ip
vi /etc/hosts

# Try to get content
curl localhost/foo
curl localhost/bar
```

## Cleanup

```sh
terraform destroy
```

## Reference

- [Ingress Controller Concept](https://google.com)
- [Nginx Ingress Controller](https://google.com)
