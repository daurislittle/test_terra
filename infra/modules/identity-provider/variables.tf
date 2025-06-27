// modules->identity-provider->variables

variable "oidc_enabled" {
  description = "OIDC enabled for provider "
  type = bool
  default = false
}

variable "saml_enabled" {
  description = "SAML enabled for provider"
  type = bool
  default = false
}

#oic
variable "oidc_url" {
  description = "issuer url"
  type = string
  default = null
}

variable "oidc_client_ids" {
  description = "Audiences list of client ids"
  type = list(string)
  default = []
}

variable "oidc_thumbprint" {
  description = "Thumbprint for oidc idp cert"
  type = string
  default = null
}

#saml
variable "saml_name" {
  description = "SAML provider name"
  type = string
  default = "saml-provider"
}

variable "saml_metadata_path" {
  description = "SAML xml metadata path"
  type = string
  default = null
}

variable "tags" {
  description = "Tags to apply"
  type = map(string)
  default = {}
}
