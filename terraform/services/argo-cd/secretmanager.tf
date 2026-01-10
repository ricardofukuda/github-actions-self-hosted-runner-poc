resource "aws_secretsmanager_secret" "website" {
  name                    = "eks-infra/website"
  recovery_window_in_days = 7 # Time window before final deletion
}

# 2. Define the secret's value using a variable
resource "aws_secretsmanager_secret_version" "website_version" {
  secret_id = aws_secretsmanager_secret.website.id
  secret_string = jsonencode({
    password = "ricardo"
    username = "ricardo"
    }
  )
}
