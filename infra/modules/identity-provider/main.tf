// module/identity-provider/main

resource "aws_iam_openid_connect_provider" "oidc" {
  count = var.oidc_enabled ? 1:0

  url = var.oidc_url
  client_id_list = var.oidc_client_ids
  thumbprint_list = [var.oidc_thumbprint]
  tags = var.tags
}

resource "aws_iam_saml_provider" "saml" {
  count = var.saml_enabled ? 1:0

  name = var.saml_name
  saml_metadata_document = file(var.saml_metadata_path)
  tags = var.tags
}