// modules->s33->variables

variable "bucket_name" {
  description = "Name for this s3 bucket"
  type = string
}

variable "force_destroy" {
  description = "Remove all objects on destroy"
  type = bool
  default = false
}

variable "acl" {
  description = "Optional canned acl Note: null = no acl resource"
  type = string
  default = null
}

variable "encrypt_algorithm" {
  description = "SSE algorithm: aes256 or kms"
  type = string
  default = "AES256"
}

variable "versioning_enabled" {
  description = "Enabled or suspend bucket versioning"
  type = bool
  default = true
}

variable "kms_key_id" {
  description = "Kms key arn/id if encrypt_algorithm = aws:kms"
  type = string
  default = null
}

variable "lifecycle_rules" {
  description = <<-EOT
  List of lifecycle rules for the following rules
  - id = string 
  - enabled - bool
  - prefix = optional(string)
  - expiration = operational({ days = number, expired_object_delete_marker = optional(bool)})
  - noncurrent_version_expiration = optional(object({days = number}))
  EOT

  type = list(object({
    id = string
    enabled = bool
    prefix = optional(string)
    expiration = optional(object({
      datys = number
      expired_object_delete_marker = optional(bool)
    }))
    noncurrent_version_expiration = optional(object({days=number}))
  }))
  default = []
}

variable "tags" {
  description = "Tags to applu to all bucket resource"
  type = map(string)
  default = {}
}