module "db" {
  source = "terraform-aws-modules/rds/aws"
  version = "6.10.0"

  multi_az                         = false
  identifier                       = var.identifier
  engine                           = var.engine
  engine_version                   = var.engine_version
  instance_class                   = var.instance_class
  allocated_storage                = var.allocated_storage
  db_name                          = var.db_name
  username                         = var.username
  manage_master_user_password      = true
  port                             = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  create_monitoring_role           = var.create_monitoring_role
  create_db_subnet_group           = var.create_db_subnet_group
  family                           = var.family # PG
  major_engine_version             = var.major_engine_version # OG
  deletion_protection              = var.deletion_protection

  vpc_security_group_ids = [aws_security_group.rds.id]

  subnet_ids             = var.database_subnets_ids

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  
  # tags = merge({
  #   name = "${var.namespace}_RDS_${var.environment}"
  # }, var.common_tags)

  

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]

  
}

