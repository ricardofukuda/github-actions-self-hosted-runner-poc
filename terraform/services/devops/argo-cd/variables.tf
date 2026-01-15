variable "env" {
  type = string
  default = "infra"
}

variable "tags" {
  type = any
  default = {
    App = "argo-cd"
    Environment = "infra"
    Terraform = "true"
  }
}

variable "domain" {
  type = string
}