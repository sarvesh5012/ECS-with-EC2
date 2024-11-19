resource "aws_secretsmanager_secret" "config_secret" {
  for_each    = var.containers
  name        = "${upper(each.key)}_SVC_SECRETS_"
  description = "Secret for my application"

}
