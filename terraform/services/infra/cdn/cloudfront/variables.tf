variable "env" {
  type    = string
  default = "infra"
}

variable "tags" {
  type = any

  default = {
    App         = "cloudfront"
    Environment = "infra"
    Terraform   = "true"
  }
}

variable "domain" {
  type = string
}
