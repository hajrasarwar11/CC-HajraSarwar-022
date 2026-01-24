# Example AMI for Amazon Linux 2 in some regions (update as needed)
locals {
	ami = "ami-06a8303596865117b" # Amazon Linux 2 AMI for me-central-1
}

module "network" {
	source            = "./modules/subnet"
	vpc_cidr_block    = var.vpc_cidr_block
	subnet_cidr_block = var.subnet_cidr_block
	availability_zone = var.availability_zone
	env_prefix        = var.env_prefix
	my_ip             = local.my_ip
}

# Frontend EC2
module "frontend" {
	source            = "./modules/webserver"
	ami               = local.ami
	instance_type     = var.instance_type
	subnet_id         = module.network.subnet_id
	security_group_id = module.network.security_group_id
	key_name          = var.env_prefix
	instance_count    = 1
	tags = {
		Name = "${var.env_prefix}-frontend"
	}
}

# Backend EC2s
module "backend" {
	source            = "./modules/webserver"
	ami               = local.ami
	instance_type     = var.instance_type
	subnet_id         = module.network.subnet_id
	security_group_id = module.network.security_group_id
	key_name          = var.env_prefix
	instance_count    = 3
	tags = {
		Name = "${var.env_prefix}-backend"
	}
}

resource "null_resource" "ansible_config" {
  triggers = {
    frontend_ip   = module.frontend.public_ips[0]
    backend_ips   = join(",", module.backend.public_ips)
  }

  depends_on = [
    module.frontend,
    module.backend
  ]

  provisioner "local-exec" {
    command = <<-EOT
      cd ansible
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts site.yaml
    EOT
  }
}
