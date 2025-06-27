//modules->iam->variables.tf

variable "role_name" {
  description = "Name for the IAAM Role"
  type = string
}

variable "assume_role_policy" {
  description = "json assume role policy"
  type = string
}

variable "s3_bucket_arns" {
  description = "List of S3 bucket arns to grant read/write"
  type = list(string)
}

variable "secrets_arns" {
  description = "List of secrets manager arns to grant read"
  type = list(string)
}

variable "api_resources" {
  description = "List or arns for the api gateway resources to allow invoke"
  type = list(string)
  default = [ "*" ]
}

variable "instance_profile_name" {
  description = "Name of iam instance profile (defaults to {role_name}-profile)"
  type = string
  default = null
}

variable "tags" {
  description = "Map of tags to applue to role and profile"
  type = map(string)
  default = {}
}

locals {
  instance_profile_name = var.instance_profile_name != null ? var.instance_profile_name : "${var.role_name}-profile"
}

