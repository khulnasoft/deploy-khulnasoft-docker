#!/usr/bin/env bash
set -e

# Description: Acts as a reverse proxy for all of the khulnasoft-frontend instances
#
# Disk: 1GB / persistent SSD
# Ports exposed to other Khulnasoft services: none
# Ports exposed to the public internet: 80 (HTTP) and 443 (HTTPS)
#
# Khulnasoft ships with a few builtin templates that cover common HTTP/HTTPS configurations:
# - HTTP only (default)
# - HTTPS with Let's Encrypt
# - HTTPS with custom certificates
#
# Follow the directions in the comments below to swap between these configurations.
#
# If none of these built-in configurations suit your needs, then you can create your own Caddyfile, see:
# https://caddyserver.com/docs/caddyfile

VOLUME="$HOME/khulnasoft-docker/caddy-storage"
./ensure-volume.sh $VOLUME 100
docker run --detach \
  --name=caddy \
  --network=khulnasoft \
  --restart=always \
  --cpus="4" \
  --memory=4g \
  -e XDG_DATA_HOME="/caddy-storage/data" \
  -e XDG_CONFIG_HOME="/caddy-storage/config" \
  -e SRC_FRONTEND_ADDRESSES="khulnasoft-frontend-0:3080" \
  -p 0.0.0.0:80:80 \
  -p 0.0.0.0:443:443 \
  -v "$VOLUME:/caddy-storage" \
  --mount type=bind,source="$(pwd)"/../caddy/builtins/http.Caddyfile,target=/etc/caddy/Caddyfile \
  index.docker.io/khulnasoft/caddy:269106_2024-04-15_5.3-d8deee19f4ae@sha256:13b9ee03ca9feba90d83129922f96ee9c1b40064a048b73feac3a334e27c3aa1
