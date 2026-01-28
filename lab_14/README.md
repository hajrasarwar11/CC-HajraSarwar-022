# Lab 14: Infrastructure as Code with Terraform and Configuration Management via Ansible

## Executive Summary

This laboratory demonstrates a comprehensive integration of Infrastructure as Code (IaC) using Terraform and configuration management using Ansible. The project provisions cloud infrastructure on AWS, automatically configures web servers with Nginx, SSL/TLS certificates, and PHP applications through Ansible playbooks and roles. By combining Terraform's infrastructure provisioning with Ansible's configuration management, the lab showcases a complete DevOps pipeline for deploying production-ready web applications.

## Objectives

The primary objectives of this laboratory are:

1. **Infrastructure Provisioning**: Use Terraform to provision EC2 instances, VPC, subnets, and security groups on AWS
2. **Configuration Management**: Implement Ansible playbooks for automated server configuration
3. **Dynamic Inventory**: Leverage Ansible's dynamic inventory plugin for AWS EC2 discovery
4. **SSL/TLS Security**: Deploy self-signed certificates and HTTPS configuration
5. **Application Deployment**: Deploy PHP-based web applications with Nginx reverse proxy
6. **Containerization**: Provision Docker and deploy containerized applications (Gitea)
7. **Automation Integration**: Automate Ansible execution from Terraform using null_resource
8. **Code Organization**: Restructure Ansible configurations using roles for modularity and reusability

## Architecture Overview

### Infrastructure Stack

```
┌─────────────────────────────────────────────┐
│           AWS Infrastructure                 │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │  VPC (10.0.0.0/16)                   │  │
│  │                                       │  │
│  │  ┌────────────────────────────────┐  │  │
│  │  │ Subnet (10.0.10.0/24)          │  │  │
│  │  │                                 │  │  │
│  │  │ ┌──────────────────────────┐   │  │  │
│  │  │ │ EC2 Instance (t3.micro)  │   │  │  │
│  │  │ │                          │   │  │  │
│  │  │ │ - Nginx                  │   │  │  │
│  │  │ │ - PHP-FPM                │   │  │  │
│  │  │ │ - Docker/Docker Compose  │   │  │  │
│  │  │ │ - Gitea (Container)      │   │  │  │
│  │  │ │ - PostgreSQL (Container) │   │  │  │
│  │  │ └──────────────────────────┘   │  │  │
│  │  │                                 │  │  │
│  │  │ ┌──────────────────────────┐   │  │  │
│  │  │ │ Security Group           │   │  │  │
│  │  │ │ - SSH (22)               │   │  │  │
│  │  │ │ - HTTP (80)              │   │  │  │
│  │  │ │ - HTTPS (443)            │   │  │  │
│  │  │ │ - Gitea (3000)           │   │  │  │
│  │  │ └──────────────────────────┘   │  │  │
│  │  └────────────────────────────────┘  │  │
│  │                                       │  │
│  │  IGW: Internet Gateway                │  │
│  │  Route Table: 0.0.0.0/0 → IGW        │  │
│  │                                       │  │
│  └──────────────────────────────────────┘  │
│                                             │
└─────────────────────────────────────────────┘
```

### Configuration Management Flow

```
Terraform Plan
    ↓
EC2 Instance Creation
    ↓
Wait for SSH Ready
    ↓
Ansible Inventory Discovery (Dynamic)
    ↓
Nginx Role (Install & Configure)
    ↓
SSL Role (Generate Certificates)
    ↓
Webapp Role (Deploy PHP Application)
    ↓
Docker Role (Install Docker & Compose)
    ↓
Gitea Role (Deploy Container Stack)
    ↓
Verify Deployment
```

## Prerequisites & Setup

### Environment Requirements

- **Development Environment**: GitHub Codespaces or local Linux environment
- **AWS Account**: With permissions to create EC2, VPC, subnets, security groups
- **Tools Required**:
  - Terraform 1.10.0+
  - Ansible 2.20.0+
  - AWS CLI v2.32.7+
  - Python 3.8+
  - boto3 and botocore libraries

### Initial Setup Steps

1. **SSH Key Generation**
   ```bash
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
   ```
   - Created ED25519 key pair for secure EC2 instance access
   - Stored keys in project backup directory

2. **AWS CLI Configuration**
   ```bash
   aws sts get-caller-identity
   ```
   - Verified AWS credentials in `me-central-1` region
   - Confirmed IAM permissions for resource creation

3. **Terraform Variable File**
   - Created `terraform.tfvars` with region, instance type, and CIDR configurations
   - Set environment prefix to "dev" for resource naming
   - Specified t3.micro instance type for cost optimization

## Detailed Task Breakdown

### Task 1: Foundation - SSH Keys and Initial Infrastructure

**Objective**: Generate secure SSH keys and provision initial EC2 infrastructure using Terraform.

**Implementation**:
- Generated ED25519 SSH key pair (more secure than RSA)
- Initialized Terraform with AWS provider configuration
- Created single EC2 instance in custom VPC with security group

**Challenges Encountered**:
- Initial SSH connectivity failed due to security group SSH port restriction
- **Resolution**: Updated security group ingress rules to allow SSH from local IP

**Outcomes**:
- ✅ Successfully provisioned EC2 instance with public IP
- ✅ SSH access verified
- ✅ Terraform state files created

---

### Task 2: Static Ansible Inventory and Connectivity

**Objective**: Create static Ansible inventory and establish SSH connectivity to EC2 instances.

**Implementation**:
- Created `hosts` file with static IP addresses
- Configured Ansible connection parameters (SSH user, private key)
- Tested connectivity using Ansible ping module

**Challenges Encountered**:
- Host key verification failures on first connection
- **Resolution**: Disabled strict host key checking in ansible.cfg

```ini
[defaults]
host_key_checking = False
```

**Outcomes**:
- ✅ Ansible connectivity established
- ✅ All hosts responding to ping

---

### Task 3: Scaling Infrastructure with Terraform Count

**Objective**: Scale infrastructure to 3 EC2 instances and implement group-based inventory.

**Implementation**:
- Modified Terraform module to use `count = 3`
- Updated Ansible inventory with group definitions: [ec2] and [droplet]
- Applied group-specific variables for SSL, user configuration

**Challenges Encountered**:
- Count syntax differences between old and new Terraform versions
- **Resolution**: Used proper for-loop syntax in outputs.tf:
```hcl
value = [for i in module.myapp-webserver : i.aws_instance.public_ip]
```

**Outcomes**:
- ✅ Successfully deployed 3 EC2 instances
- ✅ Grouped inventory for targeted deployments

---

### Task 4-5: Nginx Installation and Group-Based Configuration

**Objective**: Install and configure Nginx on targeted instance groups.

**Implementation**:
- Created multi-play Ansible playbook targeting [nginx] group
- Installed Nginx package with yum module
- Enabled and started Nginx service
- Verified default Nginx page accessibility

**Challenges Encountered**:
- Ansible facts gathering timing issues
- **Resolution**: Added explicit gather_facts task with delays

**Outcomes**:
- ✅ Nginx installed and running
- ✅ Web server accessible via HTTP

---

### Task 6: Automated SSL Certificate Generation

**Objective**: Generate self-signed SSL certificates using EC2 instance metadata.

**Implementation**:
- Implemented IMDSv2 (Instance Metadata Service v2) for secure metadata access
- Dynamically retrieved instance public IP from metadata
- Generated self-signed certificates using OpenSSL
- Applied certificate restrictions (365-day validity, specific key usage)

**Code Snippet**:
```yaml
- name: Get IMDSv2 token
  uri:
    url: "http://169.254.169.254/latest/api/token"
    method: PUT
    headers:
      X-aws-ec2-metadata-token-ttl-seconds: "3600"
    return_content: yes
  register: imdsv2_token

- name: Generate self-signed SSL certificate
  command: >
    openssl req -x509 -nodes -days 365
    -newkey rsa:2048
    -keyout /etc/ssl/private/selfsigned.key
    -out /etc/ssl/certs/selfsigned.crt
    -subj "/CN={{ public_ip.content }}"
```

**Challenges Encountered**:
- IMDSv1 deprecation warnings from AWS
- **Resolution**: Implemented IMDSv2 token-based approach with proper TTL handling

**Outcomes**:
- ✅ Self-signed certificates generated
- ✅ HTTPS access enabled

---

### Task 7: PHP Application Deployment with Templates

**Objective**: Deploy PHP-based web application with dynamic Nginx configuration.

**Implementation**:
- Created PHP metadata page displaying EC2 instance information
- Implemented Jinja2 template for Nginx configuration
- Configured PHP-FPM integration with Nginx
- Applied template variables for dynamic server names

**PHP Functionality**:
- Uses IMDSv2 for secure metadata access
- Displays: hostname, instance ID, private IP, public IP, deployment timestamp
- Responsive HTML with gradient styling

**Challenges Encountered**:
- PHP-FPM socket permission issues initially
- Template variable `server_public_ip` not defined in first run
- **Resolution**: Saved public IP as Ansible fact before template rendering

**Outcomes**:
- ✅ PHP application deployed and accessible
- ✅ HTTPS working with self-signed certificate
- ✅ Dynamic instance metadata displayed

---

### Task 8: Docker and Docker Compose Provisioning

**Objective**: Install Docker and Docker Compose for containerized workloads.

**Implementation**:
- Installed Docker package via yum
- Downloaded Docker Compose binary from official GitHub releases
- Created proper CLI plugin directory structure
- Verified Docker daemon functionality

**Challenges Encountered**:
- Docker Compose download URL architecture detection complexity
- **Resolution**: Used Ansible `lookup('pipe', 'uname -m')` for dynamic architecture detection

**Outcomes**:
- ✅ Docker 23.0.0+ installed
- ✅ Docker Compose 2.x available
- ✅ Docker daemon running and accessible

---

### Task 9: Containerized Application Deployment (Gitea)

**Objective**: Deploy Gitea (Git service) and PostgreSQL using Docker Compose.

**Implementation**:
- Created `compose.yaml` with multi-container stack
- Configured Gitea and PostgreSQL services
- Implemented persistent volumes for data storage
- Updated AWS security group to allow port 3000

**Docker Stack Configuration**:
```yaml
services:
  gitea:
    image: gitea/gitea:latest
    ports:
      - 3000:3000
    environment:
      - DB_TYPE=postgres
      - DB_HOST=db:5432

  db:
    image: postgres:alpine
    volumes:
      - gitea_postgres:/var/lib/postgresql/data
```

**Challenges Encountered**:
- Permission denied for docker command execution initially
- Container startup timing issues
- **Resolution**: 
  - Added user to docker group via Ansible
  - Implemented connection reset to apply group changes
  - Added container startup delay handling

**AWS Security Group Updates**:
- Added ingress rule for port 3000 (Gitea)
- Applied changes via `terraform apply -auto-approve`

**Outcomes**:
- ✅ Gitea container running successfully
- ✅ PostgreSQL persistent data storage configured
- ✅ Web UI accessible on port 3000

---

### Task 10: Terraform-Driven Ansible Automation

**Objective**: Automate Ansible execution directly from Terraform using null_resource.

**Implementation**:
- Added `null_resource` with `local-exec` provisioner
- Configured triggers on EC2 instance creation
- Implemented automatic playbook execution upon infrastructure creation

**Terraform Configuration**:
```hcl
resource "null_resource" "configure_server" {
  triggers = {
    webserver_public_ips = join(",", [for i in module.myapp-webserver : i.aws_instance.public_ip])
  }

  depends_on = [module.myapp-webserver]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.triggers.webserver_public_ips}, my-playbook.yaml"
  }
}
```

**Challenges Encountered**:
- Null provider not initialized initially
- SSH timeout during Ansible execution due to instance startup delay
- **Resolution**:
  - Ran `terraform init -upgrade` to fetch null provider
  - Added wait_for_ssh play with 300-second timeout

**Outcomes**:
- ✅ Full infrastructure and configuration provisioning in single `terraform apply`
- ✅ Reduced manual intervention
- ✅ Repeatable, idempotent deployments

---

### Task 11: Dynamic Inventory with AWS EC2 Plugin

**Objective**: Implement dynamic inventory discovery using Ansible's aws_ec2 plugin.

**Implementation**:
- Installed boto3 and botocore libraries
- Created `inventory_aws_ec2.yaml` with plugin configuration
- Configured AWS region for instance discovery

**Configuration**:
```yaml
---
plugin: aws_ec2
regions:
  - me-central-1

vars:
  ansible_user: ec2-user
  ansible_ssh_private_key_file: ~/.ssh/id_ed25519
```

**Challenges Encountered**:
- Boto3/botocore installation restrictions on Alpine Linux
- SSH user not being applied from inventory configuration
- **Resolution**:
  - Used `apk add py3-boto3 py3-botocore` (system package manager)
  - Added explicit SSH configuration to ansible.cfg as backup

**Outcomes**:
- ✅ Dynamic discovery of EC2 instances
- ✅ Automatic inventory updates on instance changes

---

### Task 12: Inventory Grouping by Tags and Instance Type

**Objective**: Filter and group EC2 instances by tags and instance type for targeted deployments.

**Implementation**:
- Added keyed_groups configuration to dynamic inventory
- Implemented tag-based grouping with prefix
- Implemented instance type-based grouping

**Inventory Configuration**:
```yaml
keyed_groups:
  - key: tags
    prefix: tag
    separator: "_"
  
  - key: instance_type
    prefix: instance_type
    separator: "_"
```

**Automatic Groups Created**:
- `tag_Name_dev_ec2_instance_0` (from EC2 tag)
- `instance_type_t3_micro` (from instance type)
- `instance_type_t3_nano` (from instance type)

**Usage Examples**:
```bash
# Run playbook only on dev instances
ansible-playbook -l tag_Name_dev_* my-playbook.yaml

# Run only on t3.micro instances
ansible-playbook -l instance_type_t3_micro my-playbook.yaml
```

**Outcomes**:
- ✅ Flexible, tag-based deployments
- ✅ Environment-specific configurations
- ✅ Scalable inventory management

---

### Task 13: Ansible Roles - Modular Configuration

**Objective**: Refactor monolithic playbook into reusable Ansible roles.

**Implementation**:
- Created three roles: nginx, ssl, webapp
- Organized tasks, handlers, templates, and defaults
- Implemented role dependencies and variable inheritance

**Role Structure**:
```
ansible/
├── roles/
│   ├── nginx/
│   │   ├── tasks/main.yml
│   │   └── handlers/main.yml
│   ├── ssl/
│   │   ├── defaults/main.yml
│   │   └── tasks/main.yml
│   └── webapp/
│       ├── defaults/main.yml
│       ├── tasks/main.yml
│       ├── handlers/main.yml
│       ├── templates/nginx.conf.j2
│       └── files/index.php
```

**Role Responsibilities**:

**nginx role**:
- Install Nginx package
- Install OpenSSL
- Start and enable Nginx service
- Restart handler for configuration changes

**ssl role**:
- Create SSL directories
- Retrieve EC2 public IP via IMDSv2
- Generate self-signed certificates
- Customize certificate parameters (CN, SAN, key usage)

**webapp role**:
- Install PHP-FPM and php-curl
- Deploy PHP application files
- Render Nginx configuration template
- Start and enable PHP-FPM
- Restart services as needed

**Challenges Encountered**:
- Role template variable scope confusion
- Handler execution order with multiple roles
- **Resolution**:
  - Used role defaults/main.yml for configuration variables
  - Properly namespaced variables with role names
  - Defined handlers in each role that modifies corresponding service

**Outcomes**:
- ✅ Modular, reusable configuration components
- ✅ Improved maintainability and testability
- ✅ Easier role composition for different deployments

## Key Technical Decisions

### 1. ED25519 SSH Keys
- **Decision**: Use ED25519 instead of RSA
- **Rationale**: Shorter keys, better performance, modern cryptography
- **Benefit**: Enhanced security without performance penalty

### 2. IMDSv2 for Metadata
- **Decision**: Implement token-based metadata service
- **Rationale**: AWS recommendation, more secure than IMDSv1
- **Benefit**: Protected against SSRF attacks, compliance with security best practices

### 3. Self-Signed Certificates
- **Decision**: Generate certificates on instance with EC2 public IP
- **Rationale**: Demonstrate dynamic certificate generation, lab environment
- **Note**: Production environments would use CA-signed certificates

### 4. Terraform null_resource
- **Decision**: Use for Ansible provisioning automation
- **Rationale**: No additional resource creation, dependency management
- **Benefit**: Seamless IaC integration with configuration management

### 5. Dynamic Inventory
- **Decision**: Implement aws_ec2 plugin for discovery
- **Rationale**: Automatic inventory updates, scalability
- **Benefit**: Reduced manual inventory maintenance

## Challenges and Resolutions

| Challenge | Symptom | Root Cause | Resolution |
|-----------|---------|-----------|-----------|
| SSH Connection Denied | Permission denied (publickey) | Security group SSH restricted | Added SSH ingress rule with local IP |
| Host Key Verification | Host key verification failed | SSH known_hosts not populated | Disabled host_key_checking in ansible.cfg |
| Null Provider Missing | Error: module declaration not found | Terraform dependencies not initialized | Ran `terraform init -upgrade` |
| Docker Permission Denied | docker: permission denied | User not in docker group | Added user to group, reset connection |
| Template Variable Undefined | 'server_public_ip' is undefined | Variable not saved as fact | Retrieved IP from metadata before template |
| SSH Timeout on Apply | Connection timeout | Instance not fully ready | Implemented wait_for_ssh play with 300s timeout |
| Ansible User Not Applied | Connecting as vscode instead of ec2-user | ansible.cfg configuration issue | Added explicit remote_user to ansible.cfg |
| Boto3 Installation Failed | externally-managed-environment error | Alpine Linux pip restrictions | Used apk package manager instead |
| Inventory Groups Not Created | Only aws_ec2 group visible | keyed_groups not configured | Added tag and instance_type grouping |

## Deployment Instructions

### Quick Start

```bash
# 1. Navigate to lab directory
cd /workspaces/CC-HajraSarwar-022/lab_14/Task

# 2. Create terraform.tfvars
cat > terraform.tfvars << 'EOF'
vpc_cidr_block = "10.0.0.0/16"
subnet_cidr_block = "10.0.10.0/24"
availability_zone = "me-central-1a"
env_prefix = "dev"
instance_type = "t3.micro"
public_key = "~/.ssh/id_ed25519.pub"
private_key = "~/.ssh/id_ed25519"
EOF

# 3. Initialize and apply Terraform
terraform init
terraform apply -auto-approve

# 4. Verify infrastructure
terraform output

# 5. Run Ansible playbooks (if using manual approach)
ansible-playbook -i inventory_aws_ec2.yaml my-playbook.yaml

# 6. Verify applications
curl http://<public-ip>
curl https://<public-ip> -k  # Ignore self-signed cert warning
```

### Verification Checklist

- [ ] EC2 instance created with public IP
- [ ] SSH connectivity: `ssh ec2-user@<ip> -i ~/.ssh/id_ed25519`
- [ ] Nginx accessible: http://<public-ip>
- [ ] HTTPS working: https://<public-ip> (accept SSL warning)
- [ ] PHP metadata page displayed
- [ ] SSL certificates present: `/etc/ssl/certs/selfsigned.crt`
- [ ] Docker running: `docker ps` on instance
- [ ] Gitea accessible: http://<public-ip>:3000

## Project Outcomes

### Infrastructure Metrics
- ✅ Single VPC with custom CIDR (10.0.0.0/16)
- ✅ Single subnet with 256 addressable IPs (10.0.10.0/24)
- ✅ EC2 instance(s) provisioned (t3.micro for dev, t3.nano for prod option)
- ✅ Security group with 4 ingress rules (SSH, HTTP, HTTPS, Gitea)
- ✅ Elastic IP assignment for instance persistence

### Application Stack
- ✅ Nginx web server (latest stable)
- ✅ PHP-FPM with php-curl extension
- ✅ OpenSSL for certificate generation
- ✅ Self-signed SSL certificates (365-day validity)
- ✅ Docker and Docker Compose
- ✅ Gitea (Git service) running in container
- ✅ PostgreSQL database (Alpine-based, minimal footprint)

### Automation Achievements
- ✅ Full infrastructure provisioning via Terraform (~45 seconds)
- ✅ Complete configuration via Ansible (~2-3 minutes)
- ✅ Zero-touch deployment with null_resource provisioning
- ✅ Dynamic inventory with tag-based filtering
- ✅ Role-based configuration management

## Cleanup Procedure

```bash
# 1. Destroy all infrastructure
terraform destroy -auto-approve

# 2. Verify state cleanup
cat terraform.tfstate | grep -c "aws_instance"  # Should return 0

# 3. Confirm in AWS console
# - No EC2 instances running
# - No VPCs created (except default)
# - No security groups (except default)
```

## Lessons Learned

1. **IaC Best Practices**
   - Always version-control infrastructure code
   - Use variables for environment-specific configuration
   - Implement proper state management and backups

2. **Configuration Management**
   - Idempotent playbooks prevent unwanted re-executions
   - Role-based organization scales with complexity
   - Handlers for dependency management between tasks

3. **AWS Integration**
   - IMDSv2 is the modern, secure approach for metadata access
   - Dynamic inventories eliminate manual host file maintenance
   - Tag-based automation enables flexible deployments

4. **Security**
   - Use private key files only in authorized locations
   - Disable SSH host key checking only in controlled lab environments
   - Implement certificate validation in production

5. **Operational Insights**
   - Terraform's depends_on prevents resource race conditions
   - Wait-for patterns crucial when provisioning + configuring in sequence
   - Logging and debugging output essential for troubleshooting

## References

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Ansible aws_ec2 Plugin](https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html)
- [AWS EC2 User Data and Instance Metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html)
- [Gitea Installation via Docker](https://docs.gitea.io/en-us/install-with-docker/)
- [Ansible Roles Documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)

## Conclusion

Lab 14 successfully demonstrates a complete DevOps workflow combining Infrastructure as Code and Configuration Management. By integrating Terraform for infrastructure provisioning with Ansible for configuration management, the lab showcases how modern cloud deployments can be fully automated, versioned, and made repeatable. The progression from simple static configurations to dynamic, role-based, tag-filtered deployments illustrates practical DevOps maturity levels and scalable infrastructure management patterns.

The implementation serves as a foundation for production deployments, requiring only modifications to certificate sources (use ACM), environment-specific configurations, and additional security hardening for actual use cases.

---

**Lab Completion Date**: January 28, 2026  
**Status**: ✅ All 13 tasks completed successfully  
**Total Infrastructure Cost**: ~$0.10 USD (using t3.micro free tier eligible instance)
