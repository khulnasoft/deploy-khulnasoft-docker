#!/usr/bin/env bash
set -e
source ./replicas.sh

# Rename the old ~/khulnasoft-docker/zoekt-shared-disk -> ~/khulnasoft-docker/zoekt-$1-shared-disk
# if it exists. This ensures we don't have to rebuild the search index from scratch.
if [ -e ~/khulnasoft-docker/zoekt-shared-disk ]; then
    mv ~/khulnasoft-docker/zoekt-shared-disk ~/khulnasoft-docker/zoekt-$1-shared-disk
fi

# Description: Backend for indexed text search operations.
#
# Disk: 200GB / persistent SSD
# Network: 100mbps
# Liveness probe: n/a
# Ports exposed to other Khulnasoft services: 6072/TCP
# Ports exposed to the public internet: none
#
VOLUME="$HOME/khulnasoft-docker/zoekt-$1-shared-disk"
./ensure-volume.sh $VOLUME 100
docker run --detach \
    --name=zoekt-indexserver-$1 \
    --hostname=zoekt-indexserver-$1 \
    --network=khulnasoft \
    --restart=always \
    --cpus=8 \
    --memory=16g \
    -e GOMAXPROCS=8 \
    -e HOSTNAME=zoekt-webserver-$1:6070 \
    -e SRC_FRONTEND_INTERNAL=http://khulnasoft-frontend-internal:3090 \
    -e 'OPENTELEMETRY_DISABLED=false' \
    -e 'OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317' \
    -v $VOLUME:/data/index \
    index.docker.io/khulnasoft/search-indexer:187572_2022-12-06_cbecc5321c7d@sha256:a3ae20e4130b4846e2c3078b9ba942854890348da37c8fa7ee385c081b7d1666

echo "Deployed zoekt-indexserver $1 service"
