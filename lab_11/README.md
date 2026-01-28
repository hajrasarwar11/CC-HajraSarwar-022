# Lab 11 – GH CLI Codespaces + AWS + Terraform: Variables, Collections, Sensitivity & EC2 Provisioning

## Overview
This project demonstrates the use of Terraform for AWS infrastructure provisioning, focusing on variable types, precedence, sensitivity, and practical EC2 deployment. All work was performed in a GitHub Codespace using the GH CLI.

## Objectives
- Use GH CLI and Codespace for all operations
- Practice Terraform variables: string, map, object, list, tuple, set, any, null
- Explore variable precedence: default, environment, tfvars, -var
- Work with sensitive and ephemeral variables
- Provision AWS VPC, Subnet, Routing, Security Group, and EC2 instance
- Use AWS CLI to query resources
- Avoid committing secrets using .gitignore

## Project Structure
```
Lab11/
  workspace/                    # Codespace files (optional)
  screenshots/                  # All required screenshots
  Lab11.md                      # Lab manual
  Lab11_solution.docx           # Solution in MS Word
  Lab11_solution.pdf            # Solution in PDF
```

## Steps Performed

### 1. Lab Setup (Codespace & GH CLI)
- Created and connected to a Codespace using GH CLI.
- Verified environment and documented with screenshots.

### 2. Provider & Variable Precedence
- Configured AWS provider in main.tf.
- Practiced variable precedence: default, environment variable, tfvars, and -var flag.
- Demonstrated variable value selection order with screenshots.

### 3. Variable Validation & Sensitivity
- Added validation blocks to variables for input checking.
- Created sensitive and ephemeral variables, observed their behavior in outputs and state files.
- Documented how sensitive values are masked and ephemeral values are not stored in state.

### 4. Project-level Variables, Locals, and Outputs
- Defined project-level variables and used locals for derived values.
- Output key local values for verification.

### 5. Maps, Objects, and Collections
- Practiced map and object variables, including outputs and tfvars usage.
- Defined and compared list, tuple, and set variables, observing ordering and uniqueness.
- Used locals to mutate and compare collection types.

### 6. Null, Any Type, and Dynamic Values
- Demonstrated null and any type variables.
- Used locals to merge tags conditionally.
- Tested dynamic values with string, number, list, map/object, and null types.

### 7. Git Ignore
- Created a .gitignore file to exclude .pem, tfstate, tfvars, and other sensitive files.
- Verified no secrets or state files were committed.

### 8. Infrastructure Provisioning
- Cleaned up previous files and started fresh.
- Built VPC, Subnet, Internet Gateway, Route Table, and associations.
- Switched between custom and default route tables.
- Populated terraform.tfvars with required values.
- Verified resources in AWS Console.

### 9. Security Group, Key Pair, EC2 Instance, and Nginx
- Created a security group with SSH and HTTP access.
- Generated and registered SSH key pairs, ensuring .pem files were not committed.
- Launched an EC2 instance, installed nginx via user_data (inline and script).
- Verified nginx in browser and via SSH.

### 10. Cleanup
- Destroyed all resources using Terraform.
- Verified state files and ensured no secrets were committed.

## Issues Encountered & Resolutions
- **Variable Precedence Confusion:** Resolved by testing each precedence method and documenting the results.
- **Sensitive/Ephemeral Variable Handling:** Observed and explained Terraform's masking and state file behavior.
- **Key File Exclusion:** Used .gitignore to prevent accidental commits of .pem and state files.
- **Provisioning Errors:** Fixed by verifying AWS resource dependencies and variable values.

## Security & Best Practices
- Excluded all sensitive files (.pem, tfstate, credentials) via .gitignore.
- Used strong SSH keys and did not commit secrets.
- Performed all work inside the Codespace for reproducibility and security.

## Screenshots
All required screenshots for each step are included in the `screenshots/` directory as per the lab instructions.

## Conclusion
This lab provided hands-on experience with Terraform variable management, AWS provisioning, and security best practices. All deliverables are organized and documented for review.
