#!/bin/bash

set -e

echo "================================="
echo "      OLLAMA SERVER START        "
echo "================================="

CONTAINER_NAME="ollama"

# Remove old container if exists
echo "[1] Removing old container if exists..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

# Pull latest Ollama image
echo "[2] Pulling Ollama image..."
docker pull ollama/ollama

# Start container
echo "[3] Starting Ollama container..."

docker run -d \
  --name $CONTAINER_NAME \
  -p 11434:11434 \
  -v ollama:/root/.ollama \
  ollama/ollama

echo "[4] Waiting for Ollama to start..."
sleep 5

# Pull lightweight model
echo "[5] Pulling TinyLlama model..."
docker exec $CONTAINER_NAME ollama pull tinyllama

echo ""
echo "================================="
echo "Ollama is ready"
echo "API -> http://localhost:11434"
echo "================================="
echo ""

echo "Test command:"
echo "docker exec -it ollama ollama run tinyllama"
