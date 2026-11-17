#!/bin/sh
# Simple CI test: required files exist and the page contains expected content
set -e
for f in index.html style.css products.js app.js Dockerfile k8s/deployment.yaml k8s/service.yaml; do
  [ -f "$f" ] || { echo "FAIL: $f missing"; exit 1; }
  echo "PASS: $f exists"
done
grep -q "Product Details" index.html && echo "PASS: page title found"
grep -q "price" products.js && echo "PASS: product prices found"
echo "ALL TESTS PASSED"
