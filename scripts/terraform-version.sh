#!/bin/sh
set -eu

TERRAFORM_VERSION="$(terraform version -json | jq -r '.terraform_version' || echo "unknown")"

printf '{ "terraform-version": "%s" }' "${TERRAFORM_VERSION:-unknown}"
