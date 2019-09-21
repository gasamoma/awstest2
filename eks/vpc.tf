resource "aws_vpc" "mod" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = {
    Name        = "${var.role}-${var.project}-${var.environment}"
    Project     = var.project
    Environment = var.environment
    Role        = var.role
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "mod" {
  vpc_id = aws_vpc.mod.id
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.mod.id
  cidr_block        = cidrsubnet(var.cidr, var.newbits, count.index)
  availability_zone = "${var.region}${element(split(",", var.azs), count.index)}"
  count             = var.public_subnet_count
  tags              = {
    Name        = "publicsubnet-${count.index}-${var.project}-${var.environment}"
    Project     = var.project
    Environment = var.environment
    Role        = var.role
  }

  map_public_ip_on_launch = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "public" {
  count  = var.public_subnet_count
  vpc_id = aws_vpc.mod.id
  tags   = {
    Name        = "${aws_subnet.public.*.id[count.index]}-${var.project}-${var.environment}"
    Project     = var.project
    Environment = var.environment
    Role        = var.role
  }
}

resource "aws_route" "internet_gateway" {
  count                  = var.public_subnet_count
  route_table_id         = aws_route_table.public.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mod.id
  depends_on             = ["aws_route_table.public"]
}

locals {
  aws_flow_log_name         = "${var.project}/${var.environment}/vpcflow"
  public_route_table_id     = aws_route_table.public.*.id
}


output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "public_subnets_cidr" {
  value = aws_subnet.public.*.cidr_block
}

output "vpc_id" {
  value = aws_vpc.mod.id
}

output "default_security_group_id" {
  value = aws_vpc.mod.default_security_group_id
}

output "vpc_cidr" {
  value = aws_vpc.mod.cidr_block
}

output "public_route_table_id" {
  value = local.public_route_table_id
}
output "route_table_ids" {
  value = local.route_table_ids
}
locals {
  route_table_ids       = concat(local.public_route_table_id)
  route_table_ids_count = length(local.route_table_ids)
}

output "route_table_ids_count" {
  value = local.route_table_ids_count
}
