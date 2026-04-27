#!/bin/bash

set -e

echo "======================================"
echo "   OLLAMA + OPEN WEBUI START SCRIPT   "
echo "======================================"

OLLAMA_CONTAINER="ollama"
WEBUI_CONTAINER="openwebui"
NETWORK_NAME="ai-network"

# remove old containers
echo "[1] Cleaning old containers..."
docker rm -f $OLLAMA_CONTAINER 2>/dev/null || true
docker rm -f $WEBUI_CONTAINER 2>/dev/null || true

# create network
echo "[2] Creating network..."
docker network create $NETWORK_NAME 2>/dev/null || true

# pull images
echo "[3] Pulling images..."
docker pull ollama/ollama
docker pull ghcr.io/open-webui/open-webui:main

# start ollama
echo "[4] Starting Ollama..."
docker run -d \
  --name $OLLAMA_CONTAINER \
  --network $NETWORK_NAME \
  -e OLLAMA_HOST=0.0.0.0 \
  -p 11434:11434 \
  -v ollama:/root/.ollama \
  ollama/ollama

sleep 5

# start web UI
echo "[5] Starting Open WebUI..."
docker run -d \
  --name $WEBUI_CONTAINER \
  --network $NETWORK_NAME \
  -p 3000:8080 \
  -e OLLAMA_BASE_URL=http://ollama:11434 \
  ghcr.io/open-webui/open-webui:main

echo ""
echo "======================================"
echo "Setup Complete"
echo "======================================"
echo "Ollama API : http://SERVER-IP:11434"
echo "Web UI     : http://SERVER-IP:3000"
echo ""
echo "Now open browser and chat with AI"
