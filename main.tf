module "vpc" {
  source = "./modules/vpc"

  name            = var.name
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat      = var.enable_nat
  tags            = var.tags
}