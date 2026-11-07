#!/bin/bash
# Create the namespace first so the secret has somewhere to go
kubectl create namespace shopflow --dry-run=client -o yaml | kubectl apply -f -

DB_PASSWORD=$(openssl rand -base64 12)
DATABASE_URL="postgresql+psycopg2://shopflow:${DB_PASSWORD}@postgres-svc:5432/shopflow"

kubectl create secret generic shopflow-secrets \
  --namespace shopflow \
  --from-literal=POSTGRES_PASSWORD="${DB_PASSWORD}" \
  --from-literal=DATABASE_URL="${DATABASE_URL}" \
  --dry-run=client -o yaml | kubectl apply -f -
  
echo "✅ Secrets generated and applied to the shopflow namespace."
