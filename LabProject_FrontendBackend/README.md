# Lab Project: Terraform + Ansible Nginx HA

## Overview
This project provisions a highly available multi-tier web application on AWS using Terraform and Ansible. It includes:
- Automated VPC, subnet, security group, and EC2 provisioning (Terraform)
- Automated configuration of backend (httpd) and frontend (nginx load balancer) servers (Ansible)
- Full automation: `terraform apply` triggers Ansible automatically

## Directory Structure
```
LabProject_FrontendBackend/
  *.tf
  modules/
  ansible/
    roles/
      backend/
      frontend/
    inventory/hosts
    site.yaml
  screenshots/   # (optional)
  Lab-Project-Frontend-Backend-Nginx-HA.md
  README.md
  .gitignore
```

## How to Run
1. Clone the repo and cd into `LabProject_FrontendBackend/`
2. Ensure your AWS credentials are configured (not committed!)
3. Run:
   ```
   terraform init
   terraform apply -auto-approve
   ```
   This will provision infra and run Ansible automatically.
4. To destroy all resources:
   ```
   terraform destroy -auto-approve
   ```

## Assumptions
- **Region:** me-central-1
- **Instance type:** t3.micro
- **AMI ID:** ami-06a8303596865117b (Amazon Linux 2, update as needed)
- **SSH Key:** You must have a valid key pair in AWS and locally (not committed)

## Notes
- No AWS credentials, .tfstate, .terraform, or private keys are committed
- All automation is via roles and null_resource
- Screenshots for verification are in `screenshots/` (optional)

## Author
Hajra Sarwar (Roll No: 022)
