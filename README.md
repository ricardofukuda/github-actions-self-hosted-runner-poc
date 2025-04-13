# About

POC to install GitHub Actions Self Managed Runners on Kubernetes (EKS).
It uses the "actions-runner-controller" to dinamically instantiate GitHub Runners (Pods) according to the number of GitHub workflows being executed.

This POC must belong to a GitHub Organization in order to use GitHub Application to access the repositories.