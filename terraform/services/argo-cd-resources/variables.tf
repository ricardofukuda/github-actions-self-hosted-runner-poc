variable "env" {
  type    = string
  default = "infra"
}

variable "tags" {
  type = any

  default = {
    App         = "external-secrets"
    Environment = "infra"
    Terraform   = "true"
  }
}
