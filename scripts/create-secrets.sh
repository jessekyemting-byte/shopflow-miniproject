#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace shopflow --dry-run=client -o yaml | kubectl apply -f -

if kubectl -n shopflow get secret shopflow-secrets >/dev/null 2>&1; then
  echo "Secret shopflow-secrets already exists; leaving it unchanged (the database keeps its original password)."
  exit 0
fi

DB_PASSWORD=$(openssl rand -hex 16)
DATABASE_URL="postgresql+psycopg2://shopflow:${DB_PASSWORD}@postgres-svc:5432/shopflow"

kubectl create secret generic shopflow-secrets \
  --namespace shopflow \
  --from-literal=POSTGRES_PASSWORD="${DB_PASSWORD}" \
  --from-literal=DATABASE_URL="${DATABASE_URL}"

echo "Secret shopflow-secrets created in the shopflow namespace."
