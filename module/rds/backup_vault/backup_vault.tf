resource "aws_backup_vault" "vault_name" {
  name = var.backup_vault_name
}

resource "aws_backup_plan" "backup_plan" {
  name = var.bp_name 

  rule {
    rule_name         = var.bp_rule_name
    target_vault_name = aws_backup_vault.vault_name.name
    schedule          = var.bp_rule_schedule
    start_window = var.start_window
    completion_window = var.completion_window
    schedule_expression_timezone = var.schedule_expression_timezone

    lifecycle {
      delete_after = var.delete_after
    }
  }
}

resource "aws_backup_selection" "service_selection" {
  iam_role_arn = aws_iam_role.bv_assume_role.arn
  name         = var.backup_service_selection_name
  plan_id      = aws_backup_plan.backup_plan.id

resources = var.resources_arn
  # resources = [
  #   "arn:aws:rds:ap-southeast-2:345594602304:cluster:cluster-dev",
  # ]

  # not_resources = [
  #   aws_db_instance.example.arn,
  #   aws_ebs_volume.example.arn,
  #   aws_efs_file_system.example.arn,
  # ]
}