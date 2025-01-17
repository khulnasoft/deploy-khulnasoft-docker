#!/usr/bin/env bash
set -e
source ./replicas.sh

# Description: Backend for indexed text search operations.
#
# Disk: 200GB / persistent SSD
# Network: 100mbps
# Liveness probe: HTTP GET http://zoekt-webserver-$1:6070/healthz
# Ports exposed to other Khulnasoft services: 6070/TCP
# Ports exposed to the public internet: none
#
VOLUME="$HOME/khulnasoft-docker/zoekt-$1-shared-disk"
./ensure-volume.sh $VOLUME 100
docker run --detach \
    --name=zoekt-webserver-$1 \
    --hostname=zoekt-webserver-$1 \
    --network=khulnasoft \
    --restart=always \
    --cpus=16 \
    --memory=100g \
    -e GOMAXPROCS=16 \
    -e HOSTNAME=zoekt-webserver-$1:6070 \
    -e 'OPENTELEMETRY_DISABLED=false' \
    -e 'OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317' \
    -v $VOLUME:/data/index \
    index.docker.io/khulnasoft/indexed-searcher:187572_2022-12-06_cbecc5321c7d@sha256:79bec59c17482e4039931ed083113bd8723d74c42b96c3c489062f6b33b806f0

echo "Deployed zoekt-webserver $1 service"
