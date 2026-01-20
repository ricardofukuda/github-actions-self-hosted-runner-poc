variable "env" {
  type    = string
  default = "infra"
}

variable "tags" {
  type = any

  default = {
    App         = "atlantis"
    Environment = "infra"
    Terraform   = "true"
  }
}

variable "domain" {
  type = string
}

variable "cloudfront_distribution_domain" {
  type = string
}
