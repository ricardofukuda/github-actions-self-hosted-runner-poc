include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependencies {
  paths = ["../istio", "../external-secrets"]
}

dependency "karpenter"{
  config_path = "../karpenter"
}

inputs = {
  node_iam_role_name       = dependency.karpenter.outputs.node_iam_role_name
  service_account       = dependency.karpenter.outputs.service_account
}