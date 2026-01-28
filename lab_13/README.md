# Lab 13 – Terraform IAM Management with AWS

## Overview
This project demonstrates the use of Terraform for AWS IAM management, completed within a GitHub Codespace using the GH CLI. The workflow covers IAM group and user management, policy attachments, login profile automation, access key generation, remote state with S3, and dynamic user creation from CSV.

## Objectives
- Use GH CLI and Codespace for all operations
- Manage IAM groups and users with Terraform
- Attach AWS managed policies to groups
- Automate IAM user login profile creation
- Generate and manage IAM access keys
- Implement Terraform remote state using S3
- Dynamically create IAM users from a CSV file
- Practice Terraform provisioners with bash scripts

## Project Structure
```
Lab13/
  main.tf
  variables.tf
  locals.tf
  users.csv
  create-login-profile.sh
  .gitignore
  screenshots/                  # All required screenshots
  Lab13.md                      # Lab manual
  Lab13_solution.docx           # Solution in MS Word
  Lab13_solution.pdf            # Solution in PDF
```

## Steps Performed

### 1. Lab Setup (Codespace & GH CLI)
- Created and connected to a GitHub Codespace using the GH CLI.
- Verified the environment and documented with screenshots.

### 2. IAM Group Creation
- Configured AWS provider in Terraform.
- Created an IAM group named `developers` and output its details.
- Verified group creation in the AWS Console.

### 3. IAM User Creation & Group Membership
- Added an IAM user `loadbalancer` and assigned it to the `developers` group.
- Output user details and verified group membership in the AWS Console.

### 4. Policy Attachments
- Attached `AmazonEC2FullAccess` and `IAMUserChangePassword` managed policies to the group.
- Confirmed permissions in the AWS Console.

### 5. Login Profile Automation
- Developed a bash script to automate IAM login profile creation.
- Integrated the script with Terraform using a `null_resource` and `local-exec` provisioner.
- Made the script executable and validated its operation.

### 6. Access Key Generation
- Generated access keys for the IAM user and output them as sensitive values.
- Verified that sensitive outputs are hidden in the console and explained this security feature in the documentation.

### 7. Remote State with S3
- Created an S3 bucket with versioning enabled for remote state storage.
- Configured the S3 backend in Terraform and migrated state.
- Verified state file presence in both local and S3 storage.

### 8. Dynamic User Creation from CSV
- Created a `users.csv` file with multiple user names.
- Updated Terraform configuration to use `for_each` and `csvdecode` for dynamic user, group membership, login profile, and access key creation.
- Output all user details and validated in the AWS Console.

### 9. Cleanup
- Destroyed all resources using Terraform.
- Deleted all object versions and delete markers from the S3 bucket using AWS CLI, then removed the bucket.
- Ensured all sensitive files were excluded from version control using `.gitignore`.

## Issues Encountered & Resolutions
- **Provider Errors:** Terraform apply failed due to missing providers. Resolved by running `terraform init -upgrade`.
- **S3 Bucket Deletion:** Could not delete versioned S3 bucket directly. Resolved by scripting the deletion of all object versions and delete markers before removing the bucket.
- **Sensitive Outputs:** Access key secrets were not visible in console or grep due to Terraform's sensitive output handling. Documented this as a security best practice.

## Security & Best Practices
- All sensitive files (AWS credentials, state files, etc.) are excluded via `.gitignore`.
- Sensitive outputs are not exposed in logs or state files committed to version control.
- All work was performed inside the Codespace for security and reproducibility.

## Screenshots
All required screenshots for each step are included in the `screenshots/` directory as per the lab instructions.

## Conclusion
This lab provided hands-on experience with Infrastructure as Code for AWS IAM management using Terraform, including automation, security best practices, and remote state management. All deliverables are organized and documented for review.
