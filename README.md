# About

POC to install GitHub Actions Self Managed Runners on Kubernetes (EKS).
It uses the "actions-runner-controller" to dinamically instantiate GitHub Runners (Pods) according to the number of GitHub workflows being executed.

This POC must belong to a GitHub Organization in order to use GitHub Application to access the repositories.

## Contains
- EKS Cluster
- Istio for service mesh
- GitHub Actions Self Hosted Runners on Kubernetes (EKS)

## Authentication
aws eks update-kubeconfig --region us-east-1 --name eks-infra

## Workflow for test
https://github.com/ricardofukuda-org/github-actions-self-hosted-runner-workflow-test