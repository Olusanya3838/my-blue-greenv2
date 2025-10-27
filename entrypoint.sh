#!/bin/sh
set -e

# Default values for safety
PORT=${PORT:-3000}
ACTIVE_POOL=${ACTIVE_POOL:-blue}

echo "[entrypoint] Active pool: $ACTIVE_POOL"
echo "[entrypoint] Port: $PORT"

# Remove default Nginx config if present
if [ -f /etc/nginx/conf.d/default.conf ]; then
  echo "[entrypoint] Removing default.conf..."
  rm /etc/nginx/conf.d/default.conf
fi

# Generate Nginx config from template with environment variables
echo "[entrypoint] Generating nginx.conf..."
envsubst '${PORT} ${ACTIVE_POOL}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "[entrypoint] Final nginx.conf content:"
cat /etc/nginx/nginx.conf

echo "[entrypoint] Starting Nginx..."
exec nginx -g 'daemon off;'
