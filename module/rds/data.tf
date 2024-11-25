data "aws_subnet" "db_subnet" {
  id = var.database_subnets_ids[0]
}


