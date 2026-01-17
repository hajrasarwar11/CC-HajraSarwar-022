# Assignment 2 - Multi-Tier Web Infrastructure

## Project Overview
This project demonstrates a **production-style multi-tier web infrastructure** deployed on AWS using Terraform. It includes a **Nginx server as a reverse proxy and load balancer**, three backend web servers (two primary, one backup), and secure network configurations. The setup showcases **load balancing, caching, high availability, and security best practices**.

---

## Architecture Diagram
```
                  Internet
                     │
           ┌─────────┴─────────┐
           │       HTTPS/80     │
           ▼                   ▼
      ┌─────────────┐      ┌─────────────┐
      │  Nginx LB   │      │ Security     │
      │ (Reverse    │      │ Groups       │
      │  Proxy)     │      │ (Ingress/    │
      │ - SSL/TLS   │      │  Egress)     │
      │ - Caching   │      └─────────────┘
      └─────┬───────┘
            │
   ┌────────┼─────────┐
   │        │         │
   ▼        ▼         ▼
┌─────┐  ┌─────┐   ┌─────┐
│Web-1│  │Web-2│   │Web-3│
│     │  │     │   │(BKP)│
└─────┘  └─────┘   └─────┘
 Primary  Primary   Backup
```

### Components Description
- **Nginx Server**: Handles SSL/TLS termination, caching, and reverse proxy to backend servers.
- **Web Servers**: Apache-based backend servers showing hostname, private IP, and status. Web-1 and Web-2 are primary; Web-3 is a backup server for failover.
- **Security Groups**: Control SSH access (from my IP) and HTTP/HTTPS traffic. Backend servers only accept traffic from Nginx.
- **Terraform Modules**: Modular code for networking, security, and webserver provisioning.

---

## Prerequisites
- **Required Tools**:
  - Terraform (v1.5+ recommended)
  - AWS CLI
  - SSH client

- **AWS Credentials Setup**:
  Configure AWS credentials using `aws configure`.

- **SSH Key Setup**:
  - Generate SSH key pair if not available: `ssh-keygen -t rsa -b 4096 -C "assignment2"`
  - Add public key to Terraform variable for EC2 instances.

---

## Deployment Instructions

1. **Clone repository**
```bash
git clone <repository-url>
cd Assignment2
```

2. **Configure Variables**
Edit `terraform/variables.tf` to set your IP for SSH access, instance types, and key names.

3. **Initialize Terraform**
```bash
terraform init
```

4. **Plan Deployment**
```bash
terraform plan
```

5. **Apply Deployment**
```bash
terraform apply
```
Type `yes` when prompted.

---

## Configuration Guide

- **Updating Backend IPs**:
Update `nginx.conf` upstream block and reload Nginx:
```bash
sudo systemctl reload nginx
```

- **Nginx Configuration**:
  - Reverse proxy forwards requests to backend servers.
  - SSL/TLS for HTTPS termination.
  - Caching reduces backend load.
  - Health checks monitor backend availability.

- **Testing Procedures**:
  - Load balancing: `curl` requests rotate between Web-1 and Web-2.
  - Cache HIT/MISS: repeated requests show cache HIT.
  - High availability: stopping Web-1/Web-2 routes traffic to backup Web-3.
  - Security: SSH blocked from non-authorized IPs; HTTP/HTTPS allowed to Nginx only.

---

## Architecture Details

- **Network Topology**:
  - VPC with public subnets for all servers.
  - Internet Gateway allows external access.
  - Nginx and backend servers have public IPs for SSH access.

- **Security Groups**:
  - Nginx SG: SSH from my IP, HTTP/HTTPS from anywhere.
  - Backend SG: SSH from my IP, HTTP only from Nginx SG.

- **Load Balancing Strategy**:
  - Nginx distributes requests evenly to primary servers.
  - Web-3 acts as a backup server for failover.

---

## Testing Results

- **Load Balancing Tests**: Requests were distributed evenly between Web-1 and Web-2.
- **Cache Performance Tests**: Proxy cache HIT/MISS verified using repeated requests.
- **High Availability Tests**: Backup Web-3 served traffic when primary servers were stopped.
- **Security Tests**: SSH restricted to my IP, HTTP/HTTPS restricted properly.
- **Performance Metrics**: Response times logged and verified within acceptable limits.

---

## Challenges & Solutions

- **Problems Encountered**:
  - Nginx caching misconfiguration.
  - Terraform resource dependency issues.
  - SSH connection failures from wrong IP.

- **Solutions**:
  - Corrected `proxy_cache_path` and permissions.
  - Adjusted Terraform module dependencies and variable references.
  - Updated `my_ip` variable and redeployed.

- **Lessons Learned**:
  - Importance of modular Terraform design.
  - Nginx configuration nuances for SSL and caching.
  - Testing HA scenarios is crucial.

---

## Conclusion

- Successfully deployed a multi-tier, HA web infrastructure.
- Learned skills in Terraform, Nginx configuration, AWS networking, and testing HA/load balancing.
- Future improvements: add automated SSL with Let’s Encrypt, dynamic backend discovery, and advanced monitoring.

---

## Troubleshooting

- **Common Issues & Solutions**:
  - Terraform errors: check variable values.
  - SSH failures: ensure your public IP is correctly set.
  - Nginx cache not working: check cache path and permissions.

- **Log Locations**:
  - Nginx: `/var/log/nginx/access.log`, `/var/log/nginx/error.log`
  - Apache: `/var/log/httpd/access_log`, `/var/log/httpd/error_log`

- **Debug Commands**:
```bash
terraform plan
terraform apply
terraform destroy
tail -f /var/log/nginx/error.log
tail -f /var/log/httpd/error_log
```

---

## Infrastructure Cleanup

1. Destroy infrastructure:
```bash
terraform destroy
```
Type `yes` when prompted.

2. Verify state file is empty:
```bash
cat terraform.tfstate
```

3. Check any remaining resources (should be none):
```bash
aws ec2 describe-instances --filters "Name=tag:Project,Values=Assignment-2" --query "Reservations[].Instances[].InstanceId"
```

---

## Deliverables

- Architecture diagram: `assignment_part6_readme.png`
- Terraform code and bootstrap scripts.
- Screenshots of load balancing, cache HIT/MISS, and failover.
- Configuration and testing documentation.

