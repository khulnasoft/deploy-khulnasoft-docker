#!/usr/bin/env bash
set -e

# Description: PostgreSQL database for code insights data.
#
# Disk: 128GB / persistent SSD
# Network: 1Gbps
# Liveness probe: 5432/TCP
# Ports exposed to other Khulnasoft services: 5432/TCP 9187/TCP
# Ports exposed to the public internet: none
#
VOLUME="$HOME/khulnasoft-docker/codeinsights-db-disk"
./ensure-volume.sh $VOLUME 999

docker run --detach \
  --name=codeinsights-db \
  --network=khulnasoft \
  --restart=always \
  --cpus=4 \
  --memory=2g \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_USER=postgres \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v $VOLUME:/var/lib/postgresql/data/ \
  index.docker.io/khulnasoft/postgresql-16-codeinsights:insiders

# Khulnasoft requires PostgreSQL 12+. Generally newer versions are better,
# but anything 12 and higher is supported.

echo "Deployed codeinsights-db service"
