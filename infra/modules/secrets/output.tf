// modules->secrets->outputs

output "secret_id" {
  description = "Resource id of the secret"
  value = aws_secretsmanager_secret.this.id
}

output "secrets_arn" {
  description = "Arn of the secret"
  value = aws_secretsmanager_secret.this.arn
}

output "version_id" {
  description = "Version id create by the module"
  value = aws_secretsmanager_secret.this.version_id
}