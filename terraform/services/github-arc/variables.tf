variable "env" {
  type = string
  default = "infra"
}

variable "tags" {
  type = any

  default = {
    App = "github-arc"
    Environment = "infra"
    Terraform = "true"
  }
}

variable "github_runner_version" {
  type = string
}