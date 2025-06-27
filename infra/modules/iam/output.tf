// modules->iam->outputs

output "role_name" {
  description = "Name of the iam role"
  value = aws_iam_role.this.name
}

output "role_arn" {
  description = "Arn of the iam role"
  value = aws_iam_role.this.arn
}

output "instance_profile_name" {
  description = "Name of the instance profile"
  value = local.instance_profile_name
}

output "instance_profile_arn" {
  description = "Arn of the instance profile"
  value = aws_iam_instance_profile.this.arn
}