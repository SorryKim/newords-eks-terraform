# Newords EKS Cluster with Terraform

이 프로젝트는 AWS 상에 Newords 서비스 전용 EKS 클러스터를 Terraform으로 배포하기 위한 IaC 구성입니다.

---

## 📦 구성 요소

- Terraform AWS Provider
- EKS 클러스터 (v1.29)
- 기존 VPC, Subnet, 보안 그룹 사용
- EKS 관리형 노드 그룹
- KMS 비활성화

---

## 🧩 전제 조건

- AWS CLI 인증 (`aws configure`)
- Terraform 1.3 이상 설치
- 기존 AWS 리소스:
  - VPC ID
  - Private Subnet ID 목록
  - Security Group ID 목록

---

## 📁 파일 구조

```
terraform/
├── main.tf
├── variables.tf
├── terraform.tfvars # 변수 값 정의 (Git 추적 X)
├── provider.tf
├── version.tf
├── output.tf
└── .gitignore
```

---

## ⚙️ 실행 방법

```bash
chmod +x start.sh
./start.sh
```

---

## ⚙️ 삭제 방법

```bash
chmod +x delete.sh
./delete.sh
```
