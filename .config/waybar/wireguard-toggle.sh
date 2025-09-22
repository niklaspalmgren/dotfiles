#!/bin/bash

# Check if interface parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <interface-name>"
    exit 1
fi

# WireGuard interface name from command line argument
INTERFACE="$1"

# Check if interface is active
if sudo wg show "$INTERFACE" &>/dev/null; then
    # Interface is active, disconnect it
    sudo wg-quick down "$INTERFACE"
    if [ $? -eq 0 ]; then
        command -v notify-send >/dev/null && notify-send "VPN" "Disconnected from $INTERFACE" -i network-vpn-disconnected
        exit 0
    else
        command -v notify-send >/dev/null && notify-send "VPN" "Failed to disconnect from $INTERFACE" -i dialog-error
        exit 1
    fi
else
    # Interface is not active, connect it
    sudo wg-quick up "$INTERFACE"
    if [ $? -eq 0 ]; then
        command -v notify-send >/dev/null && notify-send "VPN" "Connected to $INTERFACE" -i network-vpn
        exit 0
    else
        command -v notify-send >/dev/null && notify-send "VPN" "Failed to connect to $INTERFACE" -i dialog-error
        exit 1
    fi
fi
