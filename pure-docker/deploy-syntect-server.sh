#!/usr/bin/env bash
set -e

# Description: Backend for syntax highlighting operations.
#
# Disk: none
# Network: 100mbps
# Liveness probe: HTTP GET http://syntect-server:9238/health
# Ports exposed to other Khulnasoft services: 9238/TCP 6060/TCP
# Ports exposed to the public internet: none
#
docker run --detach \
    --name=syntect-server \
    --network=khulnasoft \
    --restart=always \
    --cpus=4 \
    --memory=6g \
    index.docker.io/khulnasoft/syntax-highlighter:187572_2022-12-06_cbecc5321c7d@sha256:b88b20f56e942cc253109bb7f4b07746ebaecc2ff7393cdaf6415ffb8778fc45

echo "Deployed syntect-server service"
