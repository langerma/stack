#!/usr/bin/env bash

docker system prune --force --volumes

echo
docker system df
