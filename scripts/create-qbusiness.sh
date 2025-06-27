#!/usr/bin/env bash

set -euo pipefail

#required inouts (needs to be passed using github secrets)
APP_NAME="${APP_NAME:-Athena_Nexus}"
DESCRIPTION="${DESCRIPTION:-Production instance of Athena Nexus}"
SAML_PROVIDER_ARN="${SAML_PROVIDER_ARN}"
ROLE_ARN="${ROLE_ARN}"
TAGS="${TAGS:-Key=Environment, Value=prod}"

echo "Creating Amazon Q Business app: $APP_NAME"

aws qbusiness create-application \
    --display-name "$APP_NAME" \
    --description "$DESCRIPTION" \
    --identity-type AWS_IAM_IDP_SAML \
    --iam-identity-provider-arn "$SAML_PROVIDER_ARN" \
    --role-arn "$ROLE_ARN" \
    --tags "$TAGS"