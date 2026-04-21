#!/bin/bash

TOR_SOCKS_HOST="127.0.0.1"
TOR_SOCKS_PORT="9050"

TOR_CONTROL_HOST="127.0.0.1"
TOR_CONTROL_PORT="9051"

echo "===== TOR AUTO INSTALL + MENU ====="

echo "[1] Updating packages..."
sudo apt update

echo "[2] Installing Tor + curl + netcat..."
sudo apt install -y tor curl netcat-openbsd

echo "[3] Configuring Tor..."

sudo bash -c 'cat >> /etc/tor/torrc <<EOF
ControlPort 9051
CookieAuthentication 0
EOF'

echo "[4] Restarting Tor..."
sudo service tor restart

sleep 5

check_ip() {
    echo ""
    echo "Current Tor IP:"
    curl --socks5 $TOR_SOCKS_HOST:$TOR_SOCKS_PORT https://api.ipify.org
    echo ""
}

new_ip() {
    echo "Requesting new Tor circuit..."
    echo -e 'AUTHENTICATE\r\nSIGNAL NEWNYM\r\nQUIT' | nc $TOR_CONTROL_HOST $TOR_CONTROL_PORT
    sleep 5
}

test_site() {
    read -p "Enter URL: " url
    curl --socks5 $TOR_SOCKS_HOST:$TOR_SOCKS_PORT "$url"
    echo ""
}

while true
do
    echo ""
    echo "===== TOR MENU ====="
    echo "Tor SOCKS Proxy : $TOR_SOCKS_HOST:$TOR_SOCKS_PORT"
    echo "Tor Control Port: $TOR_CONTROL_HOST:$TOR_CONTROL_PORT"
    echo ""
    echo "1) Check Tor IP"
    echo "2) Change Tor IP"
    echo "3) Test website via Tor"
    echo "4) Exit"

    read -p "Select option: " opt

    case $opt in
        1) check_ip ;;
        2) new_ip; check_ip ;;
        3) test_site ;;
        4) exit ;;
        *) echo "Invalid option" ;;
    esac
done
