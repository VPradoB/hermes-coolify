#!/usr/bin/env sh
set -eu

out="${1:-hermes-migrate.tar.gz}"
home="${HERMES_HOME:-$HOME/.hermes}"

tar -C "$home" -czf "$out" config.yaml .env auth.json whatsapp
chmod 600 "$out"

printf 'Created %s\n' "$out"
printf 'Upload it to the VPS and extract into /opt/data.\n'
