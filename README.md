# Terraform Deployment Modules for ECS 

This repository provides a **generic Terraform setup** to deploy an infrastructure that includes ECS with EC2 or Fargate, RDS, Backup Vault, and CI/CD roles. Configuration inputs are customizable via the `variables.yml` file.

---

## Features
- **VPC Module**: Creates VPC with public, private, and database subnets.
- **ECS Module**: Deploy ECS using EC2 or Fargate based on your requirements.
- **RDS Module**: Sets up an RDS database with backup vault integration.
- **Backup Vault**: Configures automated backup for the RDS instance.
- **CI/CD Role**: Creates an OIDC role for GitHub Actions integration.

---

## Quick Start

### Prerequisites
- Ensure you have **Terraform** installed.
- Configure your AWS credentials locally using `aws configure`.

### Steps to Deploy

1. **Clone the Repository**  
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Customize Variables**  
   Edit the `variables.yml` file to set your project-specific values:
   - **Namespace**: Project name
   - **Environment**: E.g., `dev`, `prod`
   - **VPC CIDR and Subnets**: Define your networking details.
   - **Containers**: Configure ECS container settings (image, ports, scaling, etc.).
   - **RDS**: Set database details like engine type, username, and storage.

3. **Initialize Terraform**  
   Run the following commands to initialize the modules:
   ```bash
   terraform init
   ```

4. **Plan and Apply**  
   Review the changes and deploy:
   ```bash
   terraform plan
   terraform apply
   ```

5. **Clean Up (Optional)**  
   To destroy the resources:
   ```bash
   terraform destroy
   ```

---

## Customization Guide

### ECS Deployment Type
- Use **EC2**: Set `launch_type` to `"EC2"` and provide an instance type in `variables.yml`.
- Use **Fargate**: Set `launch_type` to `"FARGATE"`. The instance type is not required.

### Backup Vault
- Modify `backup_vault_name` and backup schedule (`bp_rule_schedule`) in `variables.yml` to suit your RDS backup needs.

### RDS
- Customize the RDS configuration, such as `engine`, `db_name`, and `port`, in `variables.yml`.

---

## Outputs
- **ECS Cluster**: Name of the deployed ECS cluster.
- **RDS Endpoint**: URL for the RDS instance.
- **Backup Vault**: ARN of the created backup vault.

---

## Notes
- Ensure proper IAM permissions for Terraform to create AWS resources.
- The configuration supports scaling ECS services based on CPU and memory utilization.
- Review and adjust CloudWatch log retention periods as needed.  

For questions or issues, refer to the [Terraform AWS Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest).