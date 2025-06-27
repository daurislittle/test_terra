// modules->secrets->vaariables

variable "name" {
  description = "Name for the secret manager secret"
  type = string
}

variable "description" {
  description = "Readable description of the secret"
  type = string
  default = null
}

variable "secret_data" {
  description = <<-EOT
    Map of key->value pairs to store
    e.g. {api_name = "", api_key = "apple_sauce"}
 EOT 
 type = map(string)
}

variable "tags" {
  description = "Tags to apply to the secret"
  type = map(string)
  default = {}
}