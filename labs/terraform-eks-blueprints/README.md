# Terraform EKS Blueprints

## Getting Started

This lab is create for [Hashitalk Thai](https://events.hashicorp.com/hashitalksthailand) in 2023 with topic `Simplify EKS management with Terraform EKS Blueprints`, Please refer to this [slide](https://l.pepo.dev/hashitalk-th-2023-slide) and [video]() for the introduction on this.

### Apply

```sh
terraform init
terraform apply -target="module.vpc" -auto-approve
terraform apply -target="module.eks" -auto-approve
terraform apply -auto-approve
```

### Retrieve Kubeconfig

```sh
aws eks update-kubeconfig --name hashitalk-thai-2023 --region ap-southeast-1
```

### Apply Cluster Issuer

```sh
kubectl apply -f 10-issuer.yaml
```

### Access ArgoCD

```sh
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

kubectl port-forward svc/argo-cd-argocd-server 8080:443 -n argocd
```

### Access Simple Nginx Service

```sh
open http://hashitalk.aws.pepo.dev
```

### Destroy

```sh
terraform destroy -target="module.eks_blueprints_addons" -auto-approve
terraform destroy -target="module.eks" -auto-approve
terraform destroy -auto-approve
```

## Notes

- [Supported addons architecture](https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/blob/main/docs/architectures.md)
- [List of available addons](https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/tree/main/docs/addons)
