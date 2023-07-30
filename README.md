# Lakefs Stack

## Setup
- start **Minio**
- start **Postgress**
- setup Minio config from `config.yaml`

## Config
```yaml
logging:
  format: json
  level: WARN
  output: "-"

database:
  type: "postgres"
  postgres:
    connection_string: "postgres://postgres:postgres@postgres:5432/postgres"

auth:
  encrypt:
    secret_key: "10a718b3f285d89c36e9864494cdd1507f3bc85b342df24736ea81f9a1134bcc"

blockstore:
  type: s3
  s3:
    force_path_style: true
    endpoint: http://minio:9000
    discover_bucket_region: false
    credentials:
      access_key_id: minio_root
      secret_access_key: minio_root
```
#### Mount config file
`your_config_file:/app/config.yaml`

## Docker Image
```bash
docker run quannadev/lakefs-minio \
-e ACCESS_KEY='ACCESS_KEY' \
-e SECRET_ACCESS_KEY='SECRET_ACCESS_KEY' \
-e REPOSITORY='test'
-p 8000:8000
```

## docker build
```bash
docker build \
-e ACCESS_KEY='ACCESS_KEY' \
-e SECRET_ACCESS_KEY='SECRET_ACCESS_KEY' \
-e REPOSITORY='test'
-p 8000:8000
```

## docker compose

```bash
docker compose up -d lakefs
```