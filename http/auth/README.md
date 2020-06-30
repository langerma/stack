# Keycloak HTTP Authentication Middleware

A simple service and middleware that can secure any Router in Traefik with a
Single-Sign-On page.

## OpenID Configuration

1. Login to `https://id.$STACK_DOMAIN/auth/admin/master/console/`
2. Create new Client
   1. Client ID: `traefik-auth`
   2. Client Protocol: `openid-connect`
3. Configure Client:
   1. Access Type: `confidential`
   2. Valid Redirect URIs: `https://id.$STACK_DOMAIN/_oauth`
   3. Copy Secret from `Clients > traefik-auth > Credentials`

## Configuration

```sh
# /stack/.env

TRAEFIK_OIDC_CLIENT_ID=traefik-auth
TRAEFIK_OIDC_CLIENT_SECRET=<secret from keycloak>
TRAEFIK_OIDC_SECRET=<random string>
```

## Installation

```sh
# /stack/services.yaml

http:
http-auth:
```

## Usage

```sh
stack up --build --detach http-auth
```
