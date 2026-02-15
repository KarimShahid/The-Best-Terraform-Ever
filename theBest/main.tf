# SG module
module "sg" {
  source       = "./modules/sg"
  vpc_id       = data.terraform_remote_state.vpc.outputs.vpc_id
  default_tags = var.default_tags
  sg_map       = var.sg_map
}

# EC2 module
module "ec2" {
  source       = "./modules/ec2"
  vpc_id       = data.terraform_remote_state.vpc.outputs.vpc_id
  default_tags = var.default_tags

  instances = {
    for k, v in var.ec2_instances :
    k => merge(v, {
      subnet_id = v.subnet_type == "public" ? data.terraform_remote_state.vpc.outputs.public_subnet_ids[v.subnet_key] : data.terraform_remote_state.vpc.outputs.private_subnet_ids[v.subnet_key]

      security_group_ids = [module.sg.sg_ids[k]]
    })
  }
}
