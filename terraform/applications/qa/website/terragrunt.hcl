include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependencies {
  paths = ["../../../services/infra/istio", "../../../services/infra/external-secrets"]
}

dependency "cloudfront"{
  config_path = "../../../services/infra/cdn/cloudfront"

  mock_outputs = {
    cloudfront_distribution_domain = "mock"
  }
}

inputs = {
  cloudfront_distribution_domain       = dependency.cloudfront.outputs.cloudfront_distribution_domain
}