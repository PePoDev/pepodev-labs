# Horizontal Pod Autoscaler Lab

## Purpose

This lab will simulate k8s cluster and apply deployment and HPA (horizontal pod autoscaler) to see how auto scale work on Kubernetes.

## Getting Started

### Create Kind K8s cluster and Apply Deployment and HPA

```sh
cd (to this lab path)
terraform init
terraform apply
```

### Stress test

```sh
# Don't forget to change thread number suit to your system
wrk2 -t32 -c400 -d30s http://localhost:8080
```

## Cleanup

```sh
terraform destroy
```
