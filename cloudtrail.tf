resource "aws_cloudtrail" "trail" {
  name                          = "${var.trail_name}"
  s3_bucket_name                = "${var.audit_bucket}"
  s3_key_prefix                 = "cloudtrail"
  include_global_service_events = true

  tags = {
    project    = "infrastructure"
    managed_by = "Terraform"
  }
}

output "cloudtrail" {
  value = "${var.trail_name}"
}
