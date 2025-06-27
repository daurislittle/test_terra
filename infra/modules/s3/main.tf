// module/s3.main.tf

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = var.force_destroy
  tags = var.tags
}

#optional if we need to use this concept
resource "aws_s3_bucket_acl" "this" {
  count = var.acl != null ? 1:0
  bucket = aws_s3_bucket.this.id
  acl = var.acl
}

#optional enforce bucket
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encrypt_algorithm
      kms_master_key_id = var.encrypt_algorithm == "aws:kms" ? var.kms_key_id : null
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
        id = rule.value.id
        status = rule.value.enabled ? "Enabled" : "Disabled"

        filter {
            prefix = lookup(rule.value, "prefix", null)
        }

        dynamic "expiration" {
          for_each = rule.value.expiration != null ? [rule.value.expiration] : []
          content {
            days = expiration.value.days
            expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
          }
        }

        dynamic "noncurrent_version_expiration" {
          for_each = rule.value.noncurrent_version_expiration != null ? [rule.value.noncurrent_version_expiration] : []
          content {
            noncurrent_days = noncurrent_version_expiration.value.days
          }
        }
    }
  }
}