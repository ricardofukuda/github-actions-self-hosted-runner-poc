variable "env" {
  type    = string
  default = "infra"
}

variable "tags" {
  type = any

  default = {
    App         = "external-dns"
    Environment = "infra"
    Terraform   = "true"
  }
}
