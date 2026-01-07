# About

## argocd cli Login
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
argocd login argo.ricardoxyz.website --username admin --password <ADMIN_PASSWORD> --skip-test-tls --grpc-web
```