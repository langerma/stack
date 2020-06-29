#!/usr/bin/env bash

exec stack build --pull --parallel "$@"
