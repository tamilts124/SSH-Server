#!/bin/bash
echo "========================================"
echo "Installing DVWA (Damn Vulnerable Web Application)"
echo "========================================"

echo "[1] Removing old container..."
docker rm -f dvwa 2>/dev/null

echo "[2] Pulling latest DVWA image..."
docker pull vulnerables/web-dvwa

echo "[3] Starting DVWA container..."
docker run -d \
--name dvwa \
-p 8001:80 \
--restart unless-stopped \
vulnerables/web-dvwa

echo ""
echo "========================================"
echo "DVWA Installed Successfully"
echo "========================================"

echo "Open in browser:"
echo "http://localhost:8001"

echo ""
echo "Setup database first:"
echo "http://localhost:8001/setup.php"

echo ""
echo "Default Credentials:"
echo "Username: admin"
echo "Password: password"

echo ""
echo "After login set:"
echo "DVWA Security -> LOW"
echo ""
