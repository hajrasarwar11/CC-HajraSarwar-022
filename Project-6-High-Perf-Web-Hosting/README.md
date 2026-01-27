# Project 6 – High-Performance Web Hosting Platform

## Overview
This project implements a production-ready, high-performance web hosting platform on AWS using only the tools and topics covered in the course: Linux, Git/GitHub, AWS IAM/VPC/EC2, Terraform, Ansible, Nginx, and PHP-FPM. The platform is designed for multi-tenant, multi-site hosting with automated onboarding, SSL, caching, and monitoring.

---

## Table of Contents
- [Architecture](#architecture)
- [Repository Structure](#repository-structure)
- [Branching Strategy](#branching-strategy)
- [Terraform Infrastructure](#terraform-infrastructure)
- [Ansible Automation](#ansible-automation)
- [Monitoring & Onboarding](#monitoring--onboarding)
- [Troubleshooting & Lessons Learned](#troubleshooting--lessons-learned)
- [Why This Project is Great](#why-this-project-is-great)

---

## Architecture
- **Multi-AZ AWS VPC**: Public subnets for Nginx load balancers, private subnets for web servers.
- **Nginx Load Balancer Layer**: EC2-based, SSL termination, caching, reverse proxy, backup server.
- **Web Tier**: Nginx + PHP-FPM, multiple server blocks for customer sites, performance-tuned.
- **Content Deployment**: Ansible pushes website content to all web servers (no NFS needed).
- **Monitoring**: Bash script checks site status/latency, logs to /var/log/site_checks.log, runs via cron.

```
┌───────────────────────────────────────────────────────────────┐
│                        Customers / Users                      │
└───────────────────────────────┬───────────────────────────────┘
                                │
                                │ HTTP / HTTPS requests
                                ▼
 ┌───────────────────────────────────────────────────────────────┐
 │                         AWS VPC                               │
 │                                                               │
 │  Public Subnets (Edge Tier)                                  │
 │  ┌───────────────────────────────┐                            │
 │  │ Nginx Load Balancers (EC2)    │                            │
 │  │ - Reverse proxy + LB          │                            │
 │  │ - SSL termination             │                            │
 │  │ - Caching                     │                            │
 │  └───────────────┬──────────────┘                            │
 │                  │                                            │
 │                  ▼                                            │
 │  Private Subnets (Web Tier)                                   │
 │  ┌───────────────────────────────┐                            │
 │  │ Web Servers (EC2)             │                            │
 │  │ - Nginx + PHP-FPM             │                            │
 │  │ - Multiple server blocks      │                            │
 │  │   for customer sites          │                            │
 │  └───────────────────────────────┘                            │
 │                                                               │
 │  Content Deployment Strategy                                  │
 │  - Ansible deploys websites to all web servers                │
 │  - Same content on each web server (no NFS)                   │
 │                                                               │
 └───────────────────────────────────────────────────────────────┘
```

---

## Repository Structure
```
Project6/
├── README.md
├── .gitignore
├── terraform/
│   ├── main.tf, variables.tf, outputs.tf, backend.tf
│   ├── environments/ (test, staging, production)
│   └── modules/ (network, lb-ec2, web-ec2)
├── ansible/
│   ├── ansible.cfg, inventory/
│   ├── playbooks/ (provision, deploy, add, monitor)
│   └── roles/ (web-stack, lb-nginx, websites, monitoring)
├── websites/ (customer1, customer2, default)
└── docs/ (architecture.md, onboarding, monitoring, etc.)
```

---

## Branching Strategy
- **main**: Production
- **staging**: Pre-production
- **test**: Internal testing
- **feature/***: New features/improvements
- PRs: feature/* → test → staging → main
- Documented in this README and followed for all changes.

---

## Terraform Infrastructure
- **Network Module**: Provisions VPC, public/private subnets, IGW, NAT GW (if needed).
- **LB EC2 Module**: Provisions 2 Nginx LB EC2s (multi-AZ), security groups, outputs public/private IPs.
- **Web EC2 Module**: Provisions 2+ web EC2s (multi-AZ), security groups, outputs IDs and IPs.
- **Root Config**: Instantiates modules, exports outputs, uses environment-specific tfvars.
- **.gitignore**: Ensures no state, secrets, or credentials are tracked.

---

## Ansible Automation
- **Dynamic Inventory**: Uses AWS EC2 inventory filtered by tags (Role=lb, Role=web).
- **Web Stack Role**: Installs Nginx + PHP-FPM, configures performance, server blocks for each site.
- **LB Nginx Role**: Installs Nginx, OpenSSL, generates self-signed certs, configures SSL, caching, backup.
- **Websites Role**: Deploys site content, templates, and configs.
- **Monitoring Role**: Deploys check-site.sh, sets up cron, logs to /var/log/site_checks.log.
- **Automated Onboarding**: add-website.yml playbook for new sites, documented in onboarding guide.

---

## Monitoring & Onboarding
- **Monitoring**: Bash script checks HTTP status and response time for each site, logs results, runs via cron.
- **Onboarding**: Step-by-step documented in docs/customer-onboarding.md (inputs, playbook, verification, naming conventions).

---

## Troubleshooting & Lessons Learned
- **Issue:** Initial issues with Nginx upstream config and SSL cert paths. **Solution:** Used absolute paths and verified permissions.
- **Issue:** PHP-FPM not serving .php files. **Solution:** Ensured fastcgi_pass and socket path matched installed PHP version.
- **Issue:** Terraform state accidentally committed. **Solution:** Updated .gitignore and removed sensitive files from repo.
- **General:** Testing each component (Terraform, Ansible, Nginx, PHP-FPM) separately before full integration helped catch errors early.

---

## Why This Project is Great
- **Real-World Skills:** Simulates a real production web hosting environment using industry-standard tools.
- **Automation:** Everything is automated—infra, config, onboarding, monitoring.
- **Security:** SSL everywhere, no secrets in repo, strong .gitignore.
- **Performance:** Nginx and PHP-FPM are tuned for high concurrency and low latency.
- **Scalability:** Multi-AZ, modular, and ready for more customers/sites.
- **Documentation:** Every step is documented for easy onboarding and troubleshooting.

---

## How to Use This Project
1. Clone the repo and review the README and docs.
2. Use Terraform to provision AWS infrastructure.
3. Use Ansible to configure all servers and deploy sites.
4. Add new sites using the onboarding playbook and guide.
5. Monitor site health via the automated script and logs.

---

**If you have any questions, check the docs or open an issue!**
