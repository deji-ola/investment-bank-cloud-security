# AWS Multi-Cloud Security Baseline for Investment Banking

## Overview

Enterprise-grade Cloud Security Posture Management (CSPM) implementation designed for investment banking regulatory requirements. This Terraform-based solution provides automated security monitoring, compliance validation, and threat detection across AWS environments.

## 🎯 Business Context

Investment banks require:
- **Regulatory Compliance**: MiFID II, PRA, GDPR, PCI DSS
- **Real-time Threat Detection**: Sub-15-minute alerting for critical findings
- **Audit Trail**: Complete configuration history with 7-year retention
- **Data Protection**: Encryption at rest and in transit
- **Access Control**: Principle of least privilege with automated policy enforcement

This architecture addresses these requirements through infrastructure-as-code.

---

## 🏗️ Architecture

### Components Deployed

#### 1. AWS Security Hub
- **Purpose**: Centralized security posture management
- **Standards Enabled**:
  - CIS AWS Foundations Benchmark v1.4.0
  - PCI DSS v3.2.1
  - AWS Foundational Security Best Practices
- **Integration**: Aggregates findings from GuardDuty, Config, and other services

#### 2. Amazon GuardDuty  
- **Purpose**: Intelligent threat detection using ML
- **Monitoring**: VPC Flow Logs, DNS queries, S3 events, Kubernetes audit logs
- **Frequency**: 15-minute finding publication

#### 3. AWS Config
- **Purpose**: Continuous compliance monitoring
- **Rules**: Encrypted volumes, RDS encryption, S3 public access, IAM password policy, root MFA
- **Storage**: 7-year retention in S3

#### 4. Event-Driven Alerting
- **EventBridge**: Routes security findings by severity
- **SNS**: Email notifications for CRITICAL and HIGH findings
- **KMS**: Customer-managed encryption keys

---

## 📋 Prerequisites

- AWS Account with administrative access
- Terraform >= 1.0
- AWS CLI configured
- Valid email address for SNS notifications

---

## 🚀 Deployment

### 1. Clone Repository
```bash
git clone https://github.com/deji-ola/investment-bank-cloud-security.git
cd investment-bank-cloud-security/01-multi-cloud-cspm/aws-security-baseline/terraform
```

### 2. Configure Variables
Edit `variables.tf` and update:
- `notification_email`: Your email for security alerts
- `aws_region`: Target region (default: eu-west-2)

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Deploy
```bash
terraform plan
terraform apply
```

### 5. Confirm SNS Subscription
Check email and click confirmation link.

---

## 📊 Validation
```bash
# Verify Security Hub
aws securityhub describe-hub --region eu-west-2

# Verify GuardDuty
aws guardduty list-detectors --region eu-west-2

# View outputs
terraform output
```

---

## 💰 Cost Estimate

**First 30 days**: ~$0 (Free Tier)  
**Ongoing**: ~$10-12/month for enterprise security monitoring

---

## 🧹 Cleanup
```bash
terraform destroy
```

---

## 🔒 Security Considerations

### Implemented Best Practices
- ✅ Encryption at rest for all data stores
- ✅ KMS key rotation enabled
- ✅ S3 bucket public access blocked
- ✅ Versioning for audit integrity
- ✅ Least privilege IAM roles

### Investment Banking Specific
- **MiFID II**: 7-year data retention
- **PRA Requirements**: Continuous monitoring and immediate alerting
- **Data Classification**: KMS-encrypted storage
- **Audit Trail**: Complete configuration history

---

## 🎓 Author

**Deji Ewuola**  
Senior AWS Solutions Architect | Financial Services Specialist

**Experience**:
- NatWest Bank: CSPM across 350+ AWS accounts
- Metro Bank: Payment system cloud modernization
- 10+ years in financial services transformations

---

**Last Updated**: January 2026