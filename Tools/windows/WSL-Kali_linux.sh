#!/bin/bash

echo "Installing WSL2 and Kali Linux..."

powershell.exe -Command "
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
"

echo "Setting WSL2 as default..."

powershell.exe -Command "wsl --set-default-version 2"

echo "Installing Kali Linux..."

powershell.exe -Command "wsl --install -d kali-linux"

echo "Installation complete."
echo "Restart may be required."

echo "After restart run:"
echo "wsl -d kali-linux"
