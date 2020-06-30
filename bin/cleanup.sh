#!/usr/bin/env bash

docker system prune --force --volumes
docker system df
