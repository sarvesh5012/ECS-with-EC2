# Generate random passwords for each container
resource "random_password" "secrets" {
  for_each = var.containers

  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric  = true
}

# Create Secrets Manager secrets
resource "aws_secretsmanager_secret" "config_secret" {
  for_each    = var.containers

  name        = "${upper(each.key)}_SECRET_NEW"
  description = "Secret for my application"
}

# Add the secret values
resource "aws_secretsmanager_secret_version" "config_secret_version" {
  for_each = var.containers

  secret_id     = aws_secretsmanager_secret.config_secret[each.key].id
  secret_string = jsonencode({
    username = "${each.key}_container_user"
    password = random_password.secrets[each.key].result

  })
}
