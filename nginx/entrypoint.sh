#!/bin/sh
set -e

echo "[entrypoint] Generating Nginx config..."
if [ "$ACTIVE_POOL" = "green" ]; then
  echo "[entrypoint] Active pool is green, swapping servers..."
  sed -i 's/server app_blue/server app_green/' /etc/nginx/nginx.conf.template
  sed -i 's/server app_green backup/server app_blue backup/' /etc/nginx/nginx.conf.template
fi

envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "[entrypoint] Starting Nginx..."
exec nginx -g 'daemon off;'
