#!/usr/bin/env bash
set -e

# Description: PostgreSQL database for various data.
#
# Disk: 128GB / persistent SSD
# Network: 100mbps
# Liveness probe: 5432/TCP
# Ports exposed to other Khulnasoft services: 5432/TCP 9187/TCP
# Ports exposed to the public internet: none
#
VOLUME="$HOME/khulnasoft-docker/pgsql-disk"
./ensure-volume.sh $VOLUME 999
docker run --detach \
  --name=pgsql \
  --network=khulnasoft \
  --restart=always \
  --cpus=4 \
  --memory=2g \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v $VOLUME:/var/lib/postgresql/data/ \
  index.docker.io/khulnasoft/postgresql-16:insiders

# Khulnasoft requires PostgreSQL 12+. Generally newer versions are better,
# but anything 12 and higher is supported.

echo "Deployed pgsql service"
