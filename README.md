# CloudNativePG Containers with TimescaleDB

[![Build](https://github.com/eznix86/docker-cloudnativepg-timescale-postgis/actions/workflows/build.yaml/badge.svg)](https://github.com/eznix86/docker-cloudnativepg-timescale-postgis/actions/workflows/build.yaml)

This repo builds Docker images for [CloudNativePG](https://cloudnative-pg.io/) with the [TimescaleDB](https://timescale.com) and [Postgis](https://postgis.net/) extensions installed.

Both versions are automatically updated by Renovate bot, so new releases will be available within a few hours.

## Images

Images are available at [`ghcr.io/eznix86/docker-cloudnativepg-timescale-postgis`](https://github.com/eznix86/docker-cloudnativepg-timescale-postgis/pkgs/container/cloudnativepg-timescale-postgis).

## Deployment

Set `.spec.imageName` in the `Cluster` to use one of the container images provided by this repository.

For example:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: example
spec:
  instances: 3
  imageName: ghcr.io/eznix86/cloudnativepg-timescale-postgis:17-ts2-postgis3
  postgresql:
    shared_preload_libraries:
      - timescaledb
  bootstrap:
    initdb:
      postInitTemplateSQL:
        - CREATE EXTENSION IF NOT EXISTS timescaledb;
        - CREATE EXTENSION IF NOT EXISTS postgis;
        - CREATE EXTENSION IF NOT EXISTS postgis_topology;
        - CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
        - CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
```
