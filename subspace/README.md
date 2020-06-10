# Subspace VPN

## Subspace Initialization

- Go to https://vpn.$STACK_DOMAIN
- Create an admin account for hostmaster@$STACK_DOMAIN

## Keycloak Configuration

- Download SAML metadata from Subspace Settings
- Create client in Keycloak with metadata
- Make sure you have these settings:
  - Client Signature Required: OFF
  - Force Name ID Format: ON
  - Name ID Format
- Logout & Sign in with SSO
