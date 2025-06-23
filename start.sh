#!/opt/homebrew/bin/bash

# ✅ 1단계: EKS 클러스터 및 노드 그룹 생성
echo "=== [1단계] EKS 클러스터 + 노드 그룹 생성 중 ==="
terraform init -upgrade
terraform apply -target=module.eks -auto-approve -var-file="terraform.tfvars"

# 🔄 클러스터가 올라올 때까지 노드 확인 (최대 5분 대기)
echo "=== 클러스터 노드 Ready 상태 대기 중 ==="
for i in {1..30}; do
    ready_nodes=$(kubectl get nodes --no-headers 2>/dev/null | grep -c " Ready ")
    if [ "$ready_nodes" -ge 1 ]; then
        echo "✅ $ready_nodes 노드 Ready 상태 확인됨"
        break
    fi
    echo "⏳ 대기 중... ($i/30)"
    sleep 10
done

# ✅ kubeconfig 업데이트
echo "=== kubeconfig 업데이트 ==="
aws eks update-kubeconfig --region ap-northeast-2 --name newords-eks-cluster

# ✅ 2단계: aws-auth 및 기타 리소스 적용
echo "=== [2단계] 추가 리소스 적용 중 ==="
terraform apply -auto-approve -var-file="terraform.tfvars"

echo "✅ 모든 리소스 적용 완료"