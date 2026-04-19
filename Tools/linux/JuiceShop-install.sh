#!/bin/bash

echo "========================================"
echo "Installing OWASP Juice Shop"
echo "========================================"

echo "[1] Removing old container..."
docker rm -f juiceshop 2>/dev/null

echo "[2] Pulling image..."
docker pull bkimminich/juice-shop

echo "[3] Starting container..."
docker run -d \
--name juiceshop \
-p 8002:3000 \
--restart unless-stopped \
bkimminich/juice-shop

echo ""
echo "========================================"
echo "Juice Shop Installed Successfully"
echo "========================================"

echo "Open in browser:"
echo "http://localhost:8002"

echo ""
echo "Known Test Accounts:"
echo "Email: demo@juice-sh.op"
echo "Password: password"

echo ""
echo "Admin challenge email:"
echo "admin@juice-sh.op"
echo "(Password must be discovered)"
echo ""
