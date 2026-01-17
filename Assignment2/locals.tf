# -------------------- Dynamic IP Detection --------------------
data "http" "my_ip" {
  url = "https://icanhazip.com"
}

# -------------------- Local Values --------------------
locals {

  # Your public IP (for security group rules, etc.)
  my_ip = "${chomp(data.http.my_ip.response_body)}/32"

  # Common tags for all resources
  common_tags = {
    Environment = var.env_prefix
    Project     = "Assignment-2"
    ManagedBy   = "Terraform"
  }

  # Resource naming convention
  name_prefix = "${var.env_prefix}-assignment2"

  # Backend server configurations
  backend_servers = [
  {
    name        = "web-1"
    suffix      = "1"
    script_path = "./scripts/apache-setup.sh"
  },
  {
    name        = "web-2"
    suffix      = "2"
    script_path = "./scripts/nginx-setup.sh"
  },
  {
    name        = "web-3"
    suffix      = "3"
    script_path = "./scripts/apache-setup.sh"
  }
]
}
