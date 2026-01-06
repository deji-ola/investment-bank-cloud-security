output "security_hub_arn" {
  description = "ARN of Security Hub account"
  value       = try(aws_securityhub_account.main[0].id, "Not enabled")
}

output "guardduty_detector_id" {
  description = "ID of GuardDuty detector"
  value       = try(aws_guardduty_detector.main[0].id, "Not enabled")
}

output "sns_topic_arn" {
  description = "ARN of SNS topic for security alerts"
  value       = aws_sns_topic.security_alerts.arn
}

output "kms_key_id" {
  description = "KMS key ID for SNS encryption"
  value       = aws_kms_key.sns.id
}

output "deployment_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}