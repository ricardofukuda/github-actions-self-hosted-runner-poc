locals {
  secrets    = jsondecode(file("${path.module}/secrets/secrets.json"))
  account_id = data.aws_caller_identity.current.account_id
}
