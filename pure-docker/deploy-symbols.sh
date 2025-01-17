#!/usr/bin/env bash
set -e
source ./replicas.sh

# Description: Backend for symbols operations.
#
# Disk: 128GB / non-persistent SSD
# Network: 100mbps
# Liveness probe: none
# Ports exposed to other Khulnasoft services: 3184/TCP 6060/TCP
# Ports exposed to the public internet: none
#
VOLUME="$HOME/khulnasoft-docker/symbols-$1-disk"
./ensure-volume.sh $VOLUME 100
docker run --detach \
    --name=symbols-$1 \
    --network=khulnasoft \
    --restart=always \
    --cpus=2 \
    --memory=4g \
    -e GOMAXPROCS=2 \
    -e SRC_FRONTEND_INTERNAL=khulnasoft-frontend-internal:3090 \
    -e 'OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317' \
    -v $VOLUME:/mnt/cache \
    index.docker.io/khulnasoft/symbols:187572_2022-12-06_cbecc5321c7d@sha256:75615a60f318dc898eae2e5037efcd53e63cf28c2b8fca388b6923d215ff9db9

echo "Deployed symbols $1 service"
