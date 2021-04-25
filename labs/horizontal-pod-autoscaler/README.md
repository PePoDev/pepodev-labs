# Horizontal Pod Autoscaler Lab

## Purpose

This lab will simulate k8s cluster and apply deployment and HPA (horizontal pod autoscaler) to see how auto scale work on Kubernetes.

## Getting Started

### Provision lab by Terraform

```sh
cd (to this lab path)
terraform init
terraform apply
```

### Create workload

```sh
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://hpa-example; done"

# ctrl + c to terminate load-generator and see pod scale down (~ 5 minutes)
```

## Cleanup

```sh
terraform destroy
```

## Reference

- [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
