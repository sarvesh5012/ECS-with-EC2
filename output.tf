output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "database_subnets_ids" {
  value = module.vpc.database_subnets
}

output "db_instance_arn" {
  value = "${module.rds.db_instance_arn}"
}