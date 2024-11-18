resource "aws_secretsmanager_secret" "config_secret" {
  for_each = var.containers
  name        = "${upper(each.key)}_ENV_SECRETS"
  description = "Secret for my application"

}
