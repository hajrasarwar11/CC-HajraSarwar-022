# 🧪 Lab 9 – Codespaces + AWS: GH CLI, AWS CLI, EC2, IAM, Security Groups, Filters & Queries

---

## 🎯 Objective
In this lab you will:
- Install and authenticate GitHub CLI in your Codespace, create and connect to a Codespace.
- Install and configure the AWS CLI in the Codespace.
- Create and manage EC2 security groups, key pairs, run/stop/start/terminate EC2 instances.
- Inspect VPC resources and practice AWS describe/filter/query commands.
- Create IAM groups/users, assign policies, create access keys and test environment-variable authentication from the Codespace.
- Use AWS CLI queries and filters to extract useful information.

---

## 📋 Task List

### Task 1: GitHub CLI, Codespace Setup & Authentication
- Install GH CLI (locally), authenticate, create and connect to a Codespace.
- **Screenshots:**
  - `task1_gh_install.png` (GH CLI install)
  - `task1_gh_auth_login.png` (GH CLI auth)
  - `task1_codespace_list.png` (Codespace list)
  - `task1_codespace_ssh_connected.png` (Connected to Codespace)

### Task 2: AWS CLI Install & Configure
- Install AWS CLI in Codespace, configure credentials, verify setup.
- **Screenshots:**
  - `task2_aws_install_and_version.png` (Install & version)
  - `task2_aws_configure_and_files.png` (Configure & config files)
  - `task2_aws_get_caller_identity.png` (Caller identity)

### Task 3: EC2 Security Group & Ingress Rules
- Create security group, add SSH/HTTP rules for Codespace IP.
- **Screenshots:**
  - `task3_create_security_group_output.png`
  - `task3_describe_sg_before_ingress.png`
  - `task3_codespace_public_ip.png`
  - `task3_authorize_ssh_and_describe.png`
  - `task3_authorize_http_and_describe.png`
  - `task3_describe_sg_final.png`

### Task 4: Key Pair, EC2 Launch, SSH
- Create ED25519 key pair, launch EC2, SSH, fix permissions, manage instance lifecycle.
- **Screenshots:**
  - `task4_create_keypair_output.png`
  - `task4_describe_keypairs.png`
  - `task4_delete_keypair_optional.png`
  - `task4_run_instances_output.png`
  - `task4_describe_instances_public_ip.png`
  - `task4_ssh_permission_error_and_fix.png`
  - `task4_stop_start_terminate_commands.png`

### Task 5: AWS Describe Commands
- Use describe-* commands to inspect AWS resources.
- **Screenshots:**
  - `task5_describe_security_groups.png`
  - `task5_describe_vpcs.png`
  - `task5_describe_subnets.png`
  - `task5_describe_instances.png`
  - `task5_describe_regions.png`
  - `task5_describe_availability_zones.png`

### Task 6: IAM Group/User/Policies/Keys
- Create IAM group/user, attach policies, create login profile, access keys, test env authentication.
- **Screenshots:**
  - `task6_create_group_and_user.png`
  - `task6_add_user_to_group_and_verify.png`
  - `task6_policy_list_and_attach.png`
  - `task6_create_login_profile_and_signin.png`
  - `task6_create_access_key_output.png`
  - `task6_env_exports_and_get_user_error.png`
  - `task6_after_logout_and_get_user_success.png`

### Task 7: Filters & Queries
- Use filters and queries to find instances and attributes.
- **Screenshots:**
  - `task7_filter_by_tag_public_ip.png`
  - `task7_filter_by_instance_type.png`
  - `task7_filter_by_subnet.png`
  - `task7_filter_by_vpc.png`

### Task 8: Output Formatting for Reporting
- Use --query to format outputs in table format.
- **Screenshots:**
  - `task8_query_table_instances_name_ip.png`
  - `task8_query_table_instance_state.png`
  - `task8_query_table_instance_type_az.png`

### Cleanup
- Terminate/delete all AWS resources created in the lab.
- **Screenshots:**
  - `cleanup_terminate_instance.png`
  - `cleanup_delete_volumes_snapshots.png`
  - `cleanup_delete_security_group_and_keypair.png`
  - `cleanup_iam_users_deleted.png`
  - `cleanup_summary.png`

---


