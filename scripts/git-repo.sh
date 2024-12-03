#!/bin/sh
set -eu

OUTPUT_REPO="$(git remote get-url "$(git remote || true)" || echo "${GITHUB_REPOSITORY:-$(pwd)}")"
OUTPUT_NAME="$(basename "${OUTPUT_REPO}" | sed 's#\.git$##g' || echo "unknown")"

printf '{ "repo": "%s" }' "${OUTPUT_NAME:-unknown}"
