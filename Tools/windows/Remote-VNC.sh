#!/bin/bash

# Check password argument
if [ -z "$1" ]; then
    echo "Error: VNC password is required."
    echo ""
    echo "Usage:"
    echo "  $0 <VNC_PASSWORD>"
    echo ""
    echo "Example:"
    echo "  $0 mypassword123"
    exit 1
fi

PASSWORD=$1

git clone https://github.com/tamilts124/Remote-Desktop.git
cd Remote-Desktop || exit

choco install tightvnc -y
pip install requests bs4

net stop tvnserver

REG IMPORT vnc-settings.reg

echo "$PASSWORD" | ./vncpasswd.exe -print -legacy | python -c "
import os
hex=input().split('=')[1]
os.system(f'reg add HKLM\\SOFTWARE\\TightVNC\\Server /v Password /t REG_BINARY /d {hex} /f')
"

net start tvnserver

echo "Remote VNC Running at port 5901"
 
