variable "aws_region" {
  default = "ap-northeast-2"
}

variable "cluster_name" {
  default = "newords-eks-cluster"
}

variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type        = list(string)
  description = "기존 보안 그룹 ID 리스트"
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "desired_capacity" {
  default = 2
}

variable "max_capacity" {
  default = 3
}

variable "min_capacity" {
  default = 1
}

variable key_name {
  type = string
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI ID"
  type        = string
}
