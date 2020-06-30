# Subspace VPN

## Installation

```sh
# /stack/services.yaml

dns:
http:
keycloak:
vpn:
```

## Usage

```sh
stack up --build --detach vpn
```

## Configuration

1. Go to `https://vpn.$STACK_DOMAIN`
2. Create an account for `hostmaster@$STACK_DOMAIN`
3. Go to `Settings`
4. Paste IDP Metadata from `https://vpn.$STACK_DOMAIN/saml/metadata`

## SAML Configuration

1. Download metadata from `https://vpn.$STACK_DOMAIN/saml/metadata`
2. Login to `https://id.$STACK_DOMAIN/auth/admin/master/console/`
3. Create new Client with import metadata from Step 1
4. Configure Client:
   1. Client Signature Required: `OFF`
   2. Force Name ID Format: `ON`
   3. Name ID Format: `username`
   4. Add Mapper:
      1. Name: `username`
      2. Mapper Type: `User Property`
      3. Property: `username`
      4. Friendly Name: `username`
      5. SAML Attribute Name: `subject`
      6. SAML Attribute NameFormat: `Basic`
5. Logout and login again with SAML
