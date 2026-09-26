resource "aws_eks_cluster" "boarding" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.kubernetes_version

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids = data.aws_subnets.private.ids

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}


resource "aws_eks_node_group" "boarding" {
  cluster_name = aws_eks_cluster.boarding.name

  node_group_name = "boarding-week2-ng"

  node_role_arn = aws_iam_role.eks_node.arn

  subnet_ids = data.aws_subnets.private.ids

  instance_types = ["t3.micro"]

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 3
    min_size     = 3
    max_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy
  ]
}

resource "aws_eks_node_group" "monitoring" {
  cluster_name    = aws_eks_cluster.boarding.name
  node_group_name = "boarding-week2-monitoring-ng"
  node_role_arn   = aws_iam_role.eks_node.arn

  subnet_ids = data.aws_subnets.private.ids

  instance_types = ["t3.small"]
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    workload = "monitoring"
  }

  taint {
    key    = "workload"
    value  = "monitoring"
    effect = "NO_SCHEDULE"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy
  ]
}
