#syntax=docker/dockerfile:1.19

ARG CLOUDNATIVEPG_VERSION

FROM ghcr.io/cloudnative-pg/postgresql:$CLOUDNATIVEPG_VERSION
USER root

ARG POSTGRES_VERSION
ARG TIMESCALE_VERSION
ENV POSTGIS_MAJOR 3

RUN <<EOT
  set -eux

  apt-get update
  apt-get install -y --no-install-recommends curl ca-certificates

  . /etc/os-release 2>/dev/null
  echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $VERSION_CODENAME main" >/etc/apt/sources.list.d/timescaledb.list
  curl -Lsf https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor >/etc/apt/trusted.gpg.d/timescale.gpg

  apt-get update
  apt-get install -y --no-install-recommends \
    "timescaledb-2-postgresql-$POSTGRES_VERSION=$TIMESCALE_VERSION~debian$VERSION_ID" \
    postgresql-$POSTGRES_VERSION-postgis-$POSTGIS_MAJOR \
    postgresql-$POSTGRES_VERSION-postgis-$POSTGIS_MAJOR-scripts

  apt-get purge -y curl
  rm /etc/apt/sources.list.d/timescaledb.list /etc/apt/trusted.gpg.d/timescale.gpg
  rm -rf /var/cache/apt/* /var/lib/apt/lists/*
EOT

USER 26
