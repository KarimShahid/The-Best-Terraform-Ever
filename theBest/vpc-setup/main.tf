module "vpc" {
  source = "../modules/vpc"

  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat      = var.enable_nat
  default_tags    = var.default_tags
}