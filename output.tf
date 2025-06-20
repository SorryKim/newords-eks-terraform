output "node_group_role_arn" {
  value = module.eks.eks_managed_node_groups["default"].iam_role_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}