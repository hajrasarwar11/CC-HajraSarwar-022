# Lab 12 – Terraform Provisioners, Modules & Nginx Reverse Proxy/Load Balancer

## Overview
This project demonstrates advanced Terraform usage for infrastructure automation, including provisioners, reusable modules, and Nginx configuration as a reverse proxy and load balancer. All work was performed in a GitHub Codespace using the GH CLI.

## Objectives
- Organize Terraform code into best-practice files
- Use provisioners: user_data, remote-exec, file, and local-exec
- Create reusable modules for subnet and webserver resources
- Configure Nginx as a reverse proxy and load balancer
- Implement SSL/TLS with self-signed certificates
- Enable Nginx caching and high availability

## Project Structure
```
Lab12/
  modules/
    subnet/
      main.tf
      variables.tf
      outputs.tf
    webserver/
      main.tf
      variables.tf
      outputs.tf
  main.tf
  variables.tf
  outputs.tf
  locals.tf
  terraform.tfvars
  entry-script.sh
  apache.sh
  .gitignore
  screenshots/
  Lab12.md
  Lab12_solution.docx
  Lab12_solution.pdf
```

## Steps Performed

### 1. Lab Setup (Codespace & GH CLI)
- Created and connected to a Codespace using GH CLI.
- Verified environment and documented with screenshots.

### 2. Code Organization
- Split Terraform configuration into main.tf, variables.tf, outputs.tf, locals.tf, and terraform.tfvars.
- Ensured all variables, outputs, and local values were clearly defined.

### 3. Provisioners
- Used user_data for initial EC2 configuration.
- Replaced user_data with remote-exec for direct SSH provisioning.
- Added file and local-exec provisioners for script upload and local logging.
- Restored user_data after testing provisioners.

### 4. Subnet Module
- Created a reusable subnet module for VPC subnet, route table, and internet gateway.
- Integrated the module into the root configuration.

### 5. Webserver Module
- Developed a webserver module for EC2 instances with security groups and key pairs.
- Used module outputs for dynamic resource referencing.

### 6. HTTPS & SSL
- Updated entry-script.sh to generate self-signed certificates and configure Nginx for HTTPS.
- Verified HTTP to HTTPS redirection and browser security warnings.

### 7. Nginx Reverse Proxy
- Created apache.sh for backend web server setup.
- Configured Nginx to proxy requests to the backend server.
- Validated reverse proxy functionality in the browser.

### 8. Load Balancing
- Added a second backend server and updated Nginx for round-robin load balancing.
- Verified traffic distribution by reloading the page.

### 9. High Availability
- Configured Nginx upstream with backup servers for failover.
- Tested failover by switching primary and backup roles.

### 10. Caching
- Enabled Nginx caching and verified cache status headers in browser dev tools.
- Confirmed cache directory creation on the server.

### 11. Cleanup
- Destroyed all resources using Terraform.
- Verified empty state and cleaned up project files.

## Issues Encountered & Resolutions
- **Provisioner SSH Issues:** Resolved by ensuring correct key permissions and using the right user.
- **Nginx Config Errors:** Used `nginx -t` to validate configuration before restarting.
- **SSL Warnings:** Documented browser steps to accept self-signed certificates.
- **State File & Key Exclusion:** Used .gitignore to prevent committing sensitive and large files.

## Security & Best Practices
- Excluded all sensitive files (.pem, tfstate, credentials) via .gitignore.
- Used strong SSH keys and did not commit secrets.
- Performed all work inside the Codespace for reproducibility and security.

## Screenshots
All required screenshots for each step are included in the `screenshots/` directory as per the lab instructions.

## Conclusion
This lab provided hands-on experience with advanced Terraform features, Nginx configuration, and infrastructure best practices. All deliverables are organized and documented for review.
