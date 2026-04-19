#!/bin/bash

echo "========================================"
echo "Installing bWAPP"
echo "========================================"

echo "[1] Removing old container..."
docker rm -f bwapp 2>/dev/null

echo "[2] Pulling image..."
docker pull raesene/bwapp

echo "[3] Starting container..."
docker run -d \
--name bwapp \
-p 8004:80 \
--restart unless-stopped \
raesene/bwapp

echo ""
echo "========================================"
echo "bWAPP Installed Successfully"
echo "========================================"

echo "Open in browser:"
echo "http://localhost:8004"

echo ""
echo "First run setup:"
echo "http://localhost:8004/install.php"

echo ""
echo "Default Credentials:"
echo "Username: bee"
echo "Password: bug"
echo ""
