variable "env" {
  type    = string
  default = "infra"
}

variable "tags" {
  type = any
}

variable "service_account" {
  type = string
}
