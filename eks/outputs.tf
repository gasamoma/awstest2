output "configmap" {
  value = local.config_map_aws_auth
}
output "public_subnets" {
  value = local.public_subnets_id
}
output "certificate_data" {
  value = aws_eks_cluster.test-eks-cluster.certificate_authority.0.data
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

output "route_table_ids_count" {
  value = local.route_table_ids_count
}