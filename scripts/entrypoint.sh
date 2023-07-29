#!/usr/bin/env sh
lakefs setup --config /app/config.yaml --user-name admin --access-key-id "${ACCESS_KEY}" --secret-access-key "${SECRET_ACCESS_KEY}" || true
lakefs run --config /app/config.yaml &
echo "---- Creating repository ----"
data='{ "name": "'${REPOSITORY}'", "storage_namespace": "s3://'${REPOSITORY}'", "default_branch": "main", "sample_data": false }'
sh /app/wait-for -t 60 localhost:8000 -- curl -u "${ACCESS_KEY}":"${SECRET_ACCESS_KEY}" -X POST -H "Content-Type: application/json" -d "$data" http://localhost:8000/api/v1/repositories || true

echo ""
echo "------------------------------------------------"
echo ""
echo ""
echo "lakeFS Web UI: http://127.0.0.1:8000/      >(.＿.)<"
echo "                                             (  )_ "
echo ""
echo "                Access Key ID    : ${ACCESS_KEY}"
echo "                Secret Access Key: ${SECRET_ACCESS_KEY}"
echo "                repository       : ${REPOSITORY}"
echo ""
echo "-------- Let's go and have axolotl fun! --------"
echo ""
wait