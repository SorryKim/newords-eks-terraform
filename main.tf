module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.29"
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.private_subnet_ids
  cluster_security_group_id       = var.security_group_ids[0]
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  create_kms_key                  = false
  enable_kms_key_rotation         = false
  cluster_encryption_config       = {}

  eks_managed_node_groups = {
    default = {
      name                   = "newords-nodegroup"
      instance_types         = [var.node_instance_type]
      desired_capacity       = var.desired_capacity
      max_capacity           = var.max_capacity
      min_capacity           = var.min_capacity
      vpc_security_group_ids = var.security_group_ids

      ami_type = "CUSTOM"
      ami_id   = var.ami_id

      metadata_options = {
        http_endpoint = "enabled"
        http_tokens   = "optional"
      }

      additional_tags = {
        Name = "ubuntu-node"
      }
    }
  }

  tags = {
    Project = "newords"
    Env     = "dev"
  }
}
