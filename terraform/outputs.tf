output "vpc_id" {
  value = data.aws_vpc.boarding.id
}

output "private_subnet_ids" {
  value = data.aws_subnets.private.ids
}

output "eks_cluster_name" {
  value = aws_eks_cluster.boarding.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.boarding.endpoint
}

output "eks_node_group" {
  value = aws_eks_node_group.boarding.node_group_name
}
