include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependencies {
  paths = ["../../../infra/services/infra/istio", "../../../infra/services/infra/external-secrets"]
}
