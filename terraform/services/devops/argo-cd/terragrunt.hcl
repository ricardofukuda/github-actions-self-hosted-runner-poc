include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependencies {
  paths = ["../../infra/istio", "../../infra/karpenter-manifests"]
}

dependency "cloudfront"{
  config_path = "../../infra/cdn/cloudfront"
}

inputs = {
  cloudfront_distribution_domain       = dependency.cloudfront.outputs.cloudfront_distribution_domain
}