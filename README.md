# About

POC to install GitHub Actions Self Managed Runners on Kubernetes (EKS).
It uses the "actions-runner-controller" to dinamically instantiate GitHub Runners (Pods) according to the number of GitHub workflows being executed.

This POC must belong to a GitHub Organization in order to use GitHub Application to access the repositories.

## Contains
- EKS Cluster (Kubernetes)
- Karpenter for EC2 right sizing
- Istio for Service Mesh
- GitHub Actions Self Hosted Runners on Kubernetes (EKS)
- External Secrets (to load secrets from AWS SecretsManager)
- External DNS (integrated with istio)
- Cloudfront for CDN
- ArgoCD to deploy applications
- Atlantis with terragrunt/terraform integration
- git-crypt to encrypt secrets

## Authentication
```
aws eks update-kubeconfig --region us-east-1 --name eks-infra
```

## GH Actions Workflow for test
https://github.com/ricardofukuda-org/github-actions-self-hosted-runner-workflow-test
https://github.com/ricardofukuda-org/github-actions-self-hosted-runner-workflow-base

## ArgoCD Applications definition
https://github.com/ricardofukuda-org/argocd-application-test