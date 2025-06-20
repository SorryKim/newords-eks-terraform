module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnet_ids

  create_kms_key          = false
  enable_kms_key_rotation = false
  cluster_encryption_config = {} 

  cluster_security_group_id = var.security_group_ids[0]

  eks_managed_node_groups = {
    default = {
      instance_types         = [var.node_instance_type]
      desired_capacity       = var.desired_capacity
      max_capacity           = var.max_capacity
      min_capacity           = var.min_capacity
      vpc_security_group_ids = var.security_group_ids
    }
  }

  tags = {
    Project = "newords"
    Env     = "dev"
  }
}
