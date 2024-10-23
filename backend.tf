terraform {
  backend "s3" {
    bucket = "dev-ecs-cluster-state-bkt"
    key    = "key/terraform.tfstate"
    region = "ap-southeast-1"
    # profile = "management-forte"
    # role_arn = "arn:aws:iam::522814693269:role/TerraformBackendAccessPolicy"
    # dynamodb_table = "value"
  }
}
