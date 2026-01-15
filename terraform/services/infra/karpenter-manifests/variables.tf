variable "env" {
  type    = string
  default = "infra"
}

variable "tags" {
  type = any
  default = {
    App         = "karpenter-manifests"
    Environment = "infra"
    Terraform   = "true"
  }
}

variable "service_account" {
  type = string
}

variable "node_iam_role_name" {
  type = string
}
