variable "aws_region" {
  description = "AWS region for security controls deployment"
  type        = string
  default     = "eu-west-2"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "491085391714"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "investment-bank-security"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "enable_guardduty" {
  description = "Enable GuardDuty threat detection"
  type        = bool
  default     = true
}

variable "enable_security_hub" {
  description = "Enable AWS Security Hub"
  type        = bool
  default     = true
}

variable "enable_config" {
  description = "Enable AWS Config for compliance monitoring"
  type        = bool
  default     = true
}

variable "notification_email" {
  description = "Email address for security notifications"
  type        = string
  default     = "dejiewuola@gmail.com"
}