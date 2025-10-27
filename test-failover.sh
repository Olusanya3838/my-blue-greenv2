#!/bin/bash
set -e

echo "== Baseline (Blue active) =="
curl -s -i http://localhost:8080/version | grep X-App-Pool

echo "== Inducing chaos on Blue =="
curl -s -X POST 'http://localhost:8081/chaos/start?mode=error'

echo "== Testing failover... =="
sleep 3
pass=0; fail=0
for i in $(seq 1 30); do
  pool=$(curl -s -i http://localhost:8080/version | grep X-App-Pool | awk '{print $2}')
  if [ "$pool" = "green" ]; then
    pass=$((pass+1))
  else
    fail=$((fail+1))
  fi
  sleep 0.2
done
echo "✅ Success: $pass responses from green, ❌ Failures: $fail"
