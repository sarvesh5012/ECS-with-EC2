variable "identifier" {
  description = "The identifier for the RDS database instance"
  type        = string
  default     = "demodb"
}

# BACKUP VAULT VARIABLES

variable "backup_vault_name" {
  description = "The name of the AWS Backup Vault to store backup data."
  type        = string
}

variable "backup_service_selection_name" {
  description = "The name for the backup service selection configuration."
  type        = string
}

variable "resources_arn" {
  description = "A list of ARNs of the resources to be included in the backup plan."
  type        = list(string)
}

variable "bp_name" {
  description = "The name of the backup plan."
  type        = string
}

variable "bp_rule_name" {
  description = "The name of the backup plan rule."
  type        = string
}

variable "bp_rule_schedule" {
  description = "The schedule for the backup plan rule in cron format."
  type        = string
}

variable "delete_after" {
  description = "The number of days after which the backup is automatically deleted."
  type        = number
}


variable "schedule_expression_timezone" {}
variable "start_window" {}
variable "completion_window" {}