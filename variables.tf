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

variable "ec2_ssh_key" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
  description = "기존에 생성된 보안 그룹 ID 목록"
}
