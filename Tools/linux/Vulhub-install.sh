#!/bin/bash

echo "========================================"
echo "Installing Vulhub Vulnerability Lab (+200 real applications)"
echo "========================================"

echo "[1] Updating system..."
sudo apt update -y

echo "[2] Installing dependencies..."
sudo apt install -y git docker.io docker-compose

echo "[3] Enabling Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[4] Cloning Vulhub repository..."
cd /opt
sudo git clone https://github.com/vulhub/vulhub.git

echo "[5] Setting permissions..."
sudo chmod -R 755 /opt/vulhub

echo ""
echo "========================================"
echo "Vulhub Installed Successfully"
echo "========================================"

echo ""
echo "Location:"
echo "/opt/vulhub"
echo ""

echo "Example CVE labs:"
echo "Log4Shell"
echo "Spring4Shell"
echo "Struts2 RCE"
echo "Redis RCE"
echo "Drupal RCE"
echo "Jenkins RCE"
echo ""

echo "To start a lab:"
echo ""
echo "cd /opt/vulhub/log4j/CVE-2021-44228"
echo "docker-compose up -d"
echo ""

echo "Then open:"
echo "http://SERVER-IP:PORT"
echo ""
