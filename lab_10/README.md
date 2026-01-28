# Lab 10 – GH CLI Codespaces + AWS + Terraform: CLI Automation of VPC/Subnet Creation

## Overview
This project demonstrates the use of GitHub Codespaces, AWS CLI, and Terraform CLI for automating the creation and management of AWS VPCs and subnets. All work was performed in a Codespace using the GH CLI, following best practices for CLI automation, resource tagging, and state management.

## Objectives
- Install and authenticate GitHub CLI in Codespace
- Install and configure AWS CLI and Terraform CLI
- Use Terraform to provision AWS VPC and subnets
- Manipulate resources and investigate state via CLI
- Use queries, tags, and outputs for infrastructure reporting
- Practice state file management and resource tracking

## Project Structure
```
Lab10/
  workspace/                    # Codespace files (optional)
  screenshots/                  # All required screenshots
  Lab10.md                      # Lab manual
  Lab10_solution.docx           # Solution in MS Word
  Lab10_solution.pdf            # Solution in PDF
```

## Steps Performed

### 1. GH CLI Codespace Setup & Authentication
- Installed and authenticated GitHub CLI in Codespace.
- Connected to Codespace shell and verified environment.

### 2. AWS CLI, Terraform CLI, Provider Setup
- Installed AWS CLI and configured credentials.
- Verified AWS CLI connectivity and configuration files.
- Installed Terraform CLI and initialized provider in main.tf.
- Inspected .terraform.lock.hcl and .terraform/ directory.

### 3. VPC/Subnet Creation & Verification
- Used Terraform to create VPC and subnet resources.
- Verified resources using AWS CLI describe commands.

### 4. Data Sources, Targeted Destroy, Tagging
- Added data sources and additional subnet resources.
- Practiced targeted destroy and refresh operations.
- Tagged resources and verified tag application and removal.

### 5. State File Inspection & Terraform State Commands
- Inspected terraform.tfstate and backup files after destroy and apply.
- Used terraform state list and show to examine resource attributes.

### 6. Terraform Outputs & Attribute Reporting
- Added output blocks for resource IDs, ARNs, CIDR blocks, regions, and tags.
- Verified outputs after apply and expanded output attributes as required.

### 7. Cleanup
- Destroyed all resources and verified state files were empty after cleanup.
- Ensured no sensitive files or credentials were committed.

## Issues Encountered & Resolutions
- **CLI Authentication Issues:** Resolved by following Codespace-specific authentication steps.
- **Resource Tagging:** Verified tag application and removal through both Terraform and AWS CLI.
- **State File Management:** Practiced backup handling and state inspection to ensure resource tracking.
- **Sensitive File Exclusion:** Used .gitignore to prevent committing credentials and state files.

## Security & Best Practices
- Excluded all sensitive files (.aws, .pem, tfstate, credentials) via .gitignore.
- Performed all work inside the Codespace for reproducibility and security.
- Used CLI tools for all resource creation, modification, and destruction.

## Screenshots
All required screenshots for each step are included in the `screenshots/` directory as per the lab instructions.

## Conclusion
This lab provided hands-on experience with CLI-based AWS infrastructure automation, Terraform state management, and best practices for secure and reproducible cloud provisioning. All deliverables are organized and documented for review.
