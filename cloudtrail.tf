resource "aws_cloudtrail" "trail" {
    name = "${var.trail_name}"
    s3_bucket_name = "${var.audit_bucket}"
    s3_key_prefix = "cloudtrail"
    include_global_service_events = true
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = "${var.audit_bucket}"
  policy = "${data.aws_iam_policy_document.cloudtrail.json}"
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid = "AWSCloudTrailAclCheck"
    effect = "Allow"
    principals = {
      type = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "s3:GetBucketAcl"
    ]
    resources = [
      "arn:aws:s3:::${var.audit_bucket}"
    ]
  }
  statement {
    sid = "AWSCloudTrailWrite"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.audit_bucket}/*"
    ]
    condition {
      test = "StringEquals",
      variable = "s3:x-amz-acl",
      values = [ "bucket-owner-full-control" ]
    }
  }
}

output "cloudtrail" {
    value = "${var.trail_name}"
}
