include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependencies {
  paths = ["../../../services/infra/istio", "../../../services/infra/external-secrets"]
}