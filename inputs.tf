variable "trail_name" {
  description = "Name of the CloudTrail trail"
  default     = "cloudwatch-trail"
}

variable "audit_bucket" {
  description = "S3 bucket name to store CloudTrail logs."
}
