#!/bin/bash

echo "=== [0단계] .env 로딩 ==="
if [ -f .env ]; then
  source .env
else
  echo "❌ .env 파일 없음"
  exit 1
fi

echo "=== [1단계] Terraform 전체 적용 ==="
terraform init -upgrade
terraform apply -auto-approve -var-file="terraform.tfvars"

echo "=== kubeconfig 업데이트 ==="
aws eks update-kubeconfig --region "$REGION" --name "$EKS_CLUSTER_NAME"

echo "=== 노드 Ready 상태 대기 중 ==="
for i in {1..30}; do
  ready_nodes=$(kubectl get nodes --no-headers 2>/dev/null | grep -c " Ready ")
  if [ "$ready_nodes" -ge 1 ]; then
    echo "✅ $ready_nodes 노드 Ready 상태 확인됨"
    break
  fi
  echo "⏳ 대기 중... ($i/30)"
  sleep 10
done

echo "✅ 완료"
