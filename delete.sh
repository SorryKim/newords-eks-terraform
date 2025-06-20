#!/opt/homebrew/bin/bash

# 삭제 전 사용자 확인
echo "⚠️  Terraform으로 EKS 클러스터 및 관련 리소스를 삭제합니다."
read -p "정말로 삭제하시겠습니까? (yes 입력 시 진행): " confirm

if [ "$confirm" != "yes" ]; then
  echo "❌ 삭제 작업이 취소되었습니다."
  exit 1
fi

# Terraform 초기화 (필요 시)
echo "📦 terraform init 실행..."
terraform init -upgrade

# destroy 실행
echo "🔥 terraform destroy 실행..."
terraform destroy -var-file="terraform.tfvars" -auto-approve