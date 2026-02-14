module "vpc" {
  source = "./modules/vpc"

  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat      = var.enable_nat
  default_tags    = var.default_tags
}

# SG module
module "sg" {
  source       = "./modules/sg"
  vpc_id       = module.vpc.vpc_id
  default_tags = var.default_tags

  sg_map = {
    sonar = { ports = [9000, 6500] }
    prom  = { ports = [6501, 3000] }
  }
}


# EC2 module
module "ec2" {
  source       = "./modules/ec2"
  vpc_id       = module.vpc.vpc_id
  default_tags = var.default_tags
  name         = var.ec2_name

  instances = {
    for k, v in var.ec2_instances :
    k => merge(v, {
      subnet_id = module.vpc.public_subnet_ids["us-east-1a"]
      security_group_ids = [module.sg.sg_ids[k]]  # attach corresponding SG
    })
  }
}
