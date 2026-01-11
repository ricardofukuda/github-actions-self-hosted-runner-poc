variable "env" {
  type    = string
  default = "qa"
}

variable "tags" {
  type = any

  default = {
    App         = "website"
    Environment = "qa"
    Terraform   = "true"
  }
}
