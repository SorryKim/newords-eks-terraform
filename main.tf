# EKS 클러스터 생성
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name                    = "newords-eks-cluster"
  cluster_version                 = "1.30"
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.private_subnet_ids
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  create_kms_key                  = false
  enable_kms_key_rotation         = false
  cluster_encryption_config       = {}

  eks_managed_node_groups = {
    default = {
      name                   = "newords-nodegroup"
      instance_types         = ["t3.medium"]
      desired_capacity       = 2
      max_capacity           = 3
      min_capacity           = 1
      vpc_security_group_ids = var.security_group_ids
      key_name               = var.key_name
    }
  }
}

# 클러스터 정보 조회
data "aws_eks_cluster" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

# Kubernetes provider 설정
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# aws-auth ConfigMap에 사용자 등록
module "eks_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "20.8.4"

  providers = {
    kubernetes = kubernetes
  }

  depends_on = [module.eks]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::555182148638:user/sorrykim"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]
}
