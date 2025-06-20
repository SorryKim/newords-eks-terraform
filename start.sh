#!/opt/homebrew/bin/bash

# ✅ 1단계: 클러스터 및 노드 그룹 먼저 생성
echo "=== [1단계] EKS 클러스터 + 노드 그룹 생성 중 ==="
terraform init -upgrade
terraform apply -target=module.eks -auto-approve -var-file="terraform.tfvars"

# 🔄 클러스터가 안정화될 때까지 대기 (기본 1~3분)
echo "=== 클러스터 안정화 대기 중 (60초) ==="
sleep 60

# ✅ kubeconfig 설정 (kubectl 명령 사용을 위해)
echo "=== kubeconfig 업데이트 ==="
aws eks update-kubeconfig --region ap-northeast-2 --name newords-eks-cluster

# ✅ 2단계: aws-auth 등 추가 리소스 적용
echo "=== [2단계] aws-auth 등 후속 리소스 적용 중 ==="
terraform apply -auto-approve -var-file="terraform.tfvars"

echo "✅ 모든 리소스 적용 완료"