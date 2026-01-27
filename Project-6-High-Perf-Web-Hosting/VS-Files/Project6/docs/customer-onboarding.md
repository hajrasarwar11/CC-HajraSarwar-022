# Customer Onboarding Guide

This guide explains how to onboard a new customer website to the Project 6 cloud platform.

## 1. Inputs Needed to Add a Site
To add a new site, you need the following information:
- **site_name**: A unique identifier for the site (e.g., `customer1`)
- **server_name**: The domain name for the site (e.g., `customer1.example.com`)
- **doc_root**: The document root directory for the site (e.g., `/var/www/customer1`)
- **enable_ssl**: Whether to enable SSL (true/false)

## 2. Running the Playbook
To add a new website, run the following command from the `ansible` directory:

```bash
ansible-playbook -i inventory/aws_ec2.yml playbooks/add-website.yml \
  -e "site_name=customer1 server_name=customer1.example.com doc_root=/var/www/customer1 enable_ssl=false"
```

- Replace the variables with the actual values for the new customer.
- This will configure Nginx, deploy the website, and reload the web server.

## 3. How to Verify via Load Balancer (LB)
- After running the playbook, access the site using the load balancer's public DNS or IP address.
- Example: `http://<load-balancer-dns-or-ip>/` or `http://customer1.example.com/`
- You should see the deployed website's home page.
- You can also check the Nginx configuration on the web server: `/etc/nginx/conf.d/<site_name>.conf`

## 4. Directory and SSL Naming Conventions
- **Document Root**: `/var/www/<site_name>` (e.g., `/var/www/customer1`)
- **Nginx Config**: `/etc/nginx/conf.d/<site_name>.conf` (e.g., `/etc/nginx/conf.d/customer1.conf`)
- **SSL Certificates** (if enabled):
  - Certificate: `/etc/ssl/certs/<site_name>.crt`
  - Key: `/etc/ssl/private/<site_name>.key`
- All names should be lowercase, alphanumeric, and use hyphens or underscores if needed.

---

**For any issues, check the Ansible playbook output and the Nginx error logs on the web server.**
