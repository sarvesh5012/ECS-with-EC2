resource "aws_iam_role" "bv_assume_role" {
  name               = "AWSBackupVaultAssumeRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.bv_assume_role.name
}

resource "aws_backup_vault_policy" "backup_policy" {
  backup_vault_name = aws_backup_vault.vault_name.name
  policy            = data.aws_iam_policy_document.backup_policy.json
}