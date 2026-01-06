# AWS Multi-Cloud Security Architecture

## High-Level Architecture Diagram
```
┌─────────────────────────────────────────────────────────────────┐
│                   AWS Account (eu-west-2 - London)               │
│                                                                   │
│  ┌──────────────────┐         ┌──────────────────┐              │
│  │  Security Hub    │◄────────│   GuardDuty      │              │
│  │  - CIS v1.4.0    │         │  Threat Detection│              │
│  │  - PCI DSS v3.2  │         │  - VPC Flow Logs │              │
│  │  - AWS Foundatl  │         │  - DNS Logs      │              │
│  └────────┬─────────┘         │  - S3 Events     │              │
│           │                   └─────────┬────────┘              │
│           │                             │                        │
│           │   ┌─────────────────────────┘                        │
│           │   │                                                  │
│           ▼   ▼                                                  │
│  ┌──────────────────────────────────────┐                       │
│  │        EventBridge Rules              │                       │
│  │  (Filter: CRITICAL & HIGH findings)   │                       │
│  └──────────────┬───────────────────────┘                       │
│                 │                                                │
│                 ▼                                                │
│  ┌──────────────────────────────────────┐                       │
│  │   SNS Topic (KMS Encrypted)           │                       │
│  │   investment-bank-security-alerts     │                       │
│  └──────────────┬───────────────────────┘                       │
│                 │                                                │
│                 ▼                                                │
│         📧 Email Notification                                    │
│         (Security Team - 15min SLA)                              │
│                                                                   │
└───────────────────────────────────────────────────────────────────┘
```

## Component Details

### Security Monitoring Layer

**AWS Security Hub**
- Centralized security posture management
- Standards: CIS AWS Foundations v1.4.0, PCI DSS v3.2.1, AWS Foundational
- Aggregates findings from GuardDuty and other services
- Continuous compliance scoring

**Amazon GuardDuty**
- ML-powered intelligent threat detection
- Analyzes VPC Flow Logs, DNS logs, S3 data events
- 15-minute finding publication frequency
- Automated malware detection for EBS volumes

### Event Processing & Alerting

**Amazon EventBridge**
- Routes security findings based on severity
- Filters: CRITICAL and HIGH findings only
- Low-latency event processing (<1 second)

**Amazon SNS**
- Encrypted notification delivery (KMS)
- Email protocol for security team
- Extensible to SMS, Lambda, SQS

**AWS KMS**
- Customer-managed encryption keys
- Automatic key rotation enabled
- Fine-grained access control

## Data Flow

1. **Detection**: GuardDuty continuously analyzes logs and events
2. **Aggregation**: Security Hub collects findings from all sources
3. **Evaluation**: Findings scored against compliance standards
4. **Filtering**: EventBridge routes CRITICAL/HIGH severity only
5. **Notification**: SNS delivers encrypted alerts to security team
6. **Response**: Team investigates within 15-minute SLA

## Investment Banking Specific Design Choices

### Real-Time Alerting
- 15-minute GuardDuty frequency suitable for trading environments
- EventBridge provides sub-second routing
- SNS ensures immediate team notification

### Regulatory Compliance
- MiFID II: All security events logged for 7-year retention
- PCI DSS: Payment data security standards enforced
- Audit trail: CloudTrail logs all API calls

### Encryption Everywhere
- Data at rest: KMS encryption for SNS topics
- Data in transit: TLS 1.2+ for all communications
- Key management: Customer-managed keys, not AWS-managed

### High Availability
- Multi-AZ deployment for all services
- No single points of failure
- Regional services (Security Hub, GuardDuty) resilient to AZ outages

## Terraform Infrastructure as Code

All components deployed via Terraform:
- Repeatable across environments
- Version-controlled infrastructure
- Automated testing and validation
- GitOps workflow for changes

## Security Controls Matrix

| Control | Implementation | Standard |
|---------|---------------|----------|
| Threat Detection | GuardDuty ML analysis | CIS, AWS Foundational |
| Compliance Monitoring | Security Hub standards | CIS v1.4.0, PCI DSS |
| Encryption at Rest | KMS customer-managed keys | PCI DSS, MiFID II |
| Access Control | IAM least privilege | CIS, AWS Foundational |
| Audit Logging | CloudTrail multi-region | All standards |
| Alerting | EventBridge + SNS | Custom SLA |

## Operational Metrics

**Detection:**
- GuardDuty scans: Continuous
- Security Hub checks: Every 12 hours
- Finding publication: 15 minutes

**Response:**
- Alert delivery: <1 minute
- Team notification: Immediate
- Investigation SLA: 15 minutes
- Remediation SLA: 4 hours (CRITICAL), 24 hours (HIGH)

---

**Deployed Infrastructure**: Live in AWS Account 491085391714  
**Region**: eu-west-2 (London)  
**Terraform State**: Managed locally  
**Last Deployment**: January 2026