############################
# AMI Lookup
############################

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# EC2 Instance
resource "aws_instance" "this" {
  for_each                = var.instances

  ami                     = data.aws_ami.ubuntu.id

  instance_type           = each.value.instance_type
  key_name                = each.value.key_name
  subnet_id               = each.value.subnet_id
  # vpc_security_group_ids  = [aws_security_group.this[each.key].id]
  vpc_security_group_ids  = each.value.security_group_ids  # <- now comes from SG module
  tags = merge(
    each.value.tags,      # custom tags per instance
    { Name = each.key }   # Name tag = key in the map
  )

  root_block_device {
    volume_type           = each.value.volume_type
    volume_size           = each.value.volume_size
    delete_on_termination = true
  }

  credit_specification {
    cpu_credits = "standard"
  }
}

######## Attaching EIP to the instance #############
resource "aws_eip" "this" {
  for_each = aws_instance.this  # loop over all created EC2 instances

  instance = each.value.id      # attach EIP to the corresponding instance
  domain   = "vpc"
}
