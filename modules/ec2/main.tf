# Security Group
resource "aws_security_group" "this" {
  name_prefix = "${var.name}-sg"
  vpc_id      = var.vpc_id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Dynamic app ports
  # Only created if var.ports has values
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name = "${var.name}-sg"
  })
}

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
  vpc_security_group_ids  = each.value.security_group_ids
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
