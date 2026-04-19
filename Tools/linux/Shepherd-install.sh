#!/bin/bash

echo "========================================"
echo "Installing OWASP Security Shepherd"
echo "========================================"

echo "[1] Removing old container..."
docker rm -f shepherd 2>/dev/null

echo "[2] Pulling image..."
docker pull ismisepaul/securityshepherd

echo "[3] Starting container..."
docker run -d \
--name shepherd \
-p 8005:8080 \
--restart unless-stopped \
ismisepaul/securityshepherd

echo ""
echo "========================================"
echo "OWASP Security Shepherd Installed Successfully"
echo "========================================"

echo "Open in browser:"
echo "http://localhost:8005"

echo ""
echo "Default Credentials:"
echo "Username: admin"
echo "Password: password"

echo ""
echo "Or register a new account from the login page."
echo ""
