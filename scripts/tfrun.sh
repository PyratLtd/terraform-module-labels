#!/bin/sh

OUTPUT_GITHUB_REPO="$(git remote get-url "$(git remote || true)" || echo "${GITHUB_REPOSITORY:-unknown}")"

cat <<EOF
{
    "repo": "${OUTPUT_GITHUB_REPO:-unknown}"
}
EOF
