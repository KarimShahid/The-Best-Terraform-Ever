module "vpc" {
  source = "./modules/vpc"

  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat      = var.enable_nat
  default_tags    = var.default_tags
}


module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  ports         = var.ec2_ports
  default_tags  = var.default_tags

  name          = var.ec2_name
  instances     = var.ec2_instances
}

