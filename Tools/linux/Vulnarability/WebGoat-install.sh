#!/bin/bash

echo "========================================"
echo "Installing OWASP WebGoat"
echo "========================================"

echo "[1] Removing old container..."
docker rm -f webgoat 2>/dev/null

echo "[2] Pulling image..."
docker pull webgoat/webgoat

echo "[3] Starting container..."
docker run -d \
--name webgoat \
-p 8003:8080 \
--restart unless-stopped \
webgoat/webgoat

echo ""
echo "========================================"
echo "WebGoat Installed Successfully"
echo "========================================"

echo "Open in browser:"
echo "http://localhost:8003/WebGoat"

echo ""
echo "Default Credentials:"
echo "Username: guest"
echo "Password: guest"

echo ""
echo "You can also register a new account."
echo ""
