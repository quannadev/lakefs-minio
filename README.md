# Lakefs Stack

## Setup
- start **Minio**
- start **Postgress**
- setup Minio config from `config.yaml`

## docker build
```bash
docker build \
-e ACCESS_KEY='ACCESS_KEY' \
-e SECRET_ACCESS_KEY='SECRET_ACCESS_KEY' \
-e REPOSITORY='test'
```

## docker compose

```bash
docker compose up -d lakefs
```