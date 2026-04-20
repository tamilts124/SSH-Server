#!/bin/bash
set -e

echo "Updating package list..."
sudo apt update

echo "Installing Docker (lightweight)..."
sudo apt install -y docker.io

echo "Starting Docker service..."
sudo service docker start

echo "Enabling Docker at startup (WSL safe fallback)..."
sudo update-rc.d docker enable >/dev/null 2>&1 || true

echo "Adding user to docker group..."
sudo usermod -aG docker $USER

echo ""
echo "Docker installation complete."
echo "Run this after reopening shell:"
echo "docker run hello-world"
