resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = merge(var.tags, {
    Name = "${var.name}-vpc"
  })
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.name}-public-${each.key}"
  })
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = merge(var.tags, {
    Name = "${var.name}-private-${each.key}"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { Name = "${var.name}-igw" })
}

# Create exactly one public route table
# Not using for_each for Route Table as only one RT in public subnet is needed.
resource "aws_route_table" "public" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route_table_association" "public" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_eip" "nat" {
  for_each = var.enable_nat && length(var.private_subnets) > 0 ? { for az in keys(var.private_subnets) : az => az } : {}

  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  for_each = var.enable_nat && length(var.private_subnets) > 0 ? { for az in keys(var.private_subnets) : az => az } : {}

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = merge(var.tags, {
    Name = "${var.name}-nat-${each.key}"
  })
}

# Here for_each does make sense, because One private RT per AZ (best practice for HA NAT)
resource "aws_route_table" "private" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = try(aws_nat_gateway.this[each.key].id, null)
  }

  tags = merge(var.tags, {
    Name = "${var.name}-private-rt-${each.key}"
  })
}

resource "aws_route_table_association" "private" {
  for_each       = aws_route_table.private
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = each.value.id
}


# Need to allow creation of Mulitple Subnets in single AZ
# USe list of maps for that
# resource "aws_subnet" "public" {
#   for_each = { for idx, sub in var.public_subnets : idx => sub }

#   vpc_id            = aws_vpc.this.id
#   cidr_block        = each.value.cidr
#   availability_zone = each.value.az

#   tags = merge(var.tags, { Name = "${var.name}-public-${each.key}" })
# }

#  Yesari garnu parcha haiii!
# public_subnets = [
#   { az = "us-east-1a", cidr = "10.0.1.0/24" },
#   { az = "us-east-1a", cidr = "10.0.2.0/24" },
#   { az = "us-east-1b", cidr = "10.0.3.0/24" },
# ]