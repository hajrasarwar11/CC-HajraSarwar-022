provider "aws" {
	region = var.aws_region
}

module "network" {
	source              = "./modules/network"
	vpc_cidr            = var.vpc_cidr
	public_subnet_cidrs = var.public_subnet_cidrs
	private_subnet_cidrs = var.private_subnet_cidrs
	azs                 = var.azs
}

module "lb_ec2" {
	source            = "./modules/lb-ec2"
	vpc_id            = module.network.vpc_id
	public_subnet_ids = module.network.public_subnet_ids
	ami_id            = var.ami_id
	instance_type     = var.instance_type_lb
	admin_cidr        = var.admin_cidr
	environment       = var.environment
	project           = var.project
	key_name          = var.key_name
}

module "web_ec2" {
	source             = "./modules/web-ec2"
	private_subnet_ids = module.network.private_subnet_ids
	public_subnet_ids  = module.network.public_subnet_ids
	ami_id             = var.ami_id
	instance_type      = var.instance_type_web
	admin_cidr         = var.admin_cidr
	lb_sg_id           = module.lb_ec2.lb_sg_id
	environment        = var.environment
	project            = var.project
	instance_count     = var.web_instance_count
	vpc_id             = module.network.vpc_id
	key_name           = var.key_name
}
>>>>>>> f31ddf2 (Finalize .gitignore, README, and Terraform configs for branching)
