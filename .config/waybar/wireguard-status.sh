#!/bin/bash

interfaces=$(wg show interfaces 2>/dev/null)

if [[ -n $interfaces ]]; then
    echo "{\"text\": \"󰖂\", \"class\": \"connected\", \"tooltip\": \"VPN\n\nStatus: connected to $interfaces\", \"alt\": \"connected\"}"
else
    echo "{\"text\": \"󰖂\", \"class\": \"disconnected\", \"tooltip\": \"VPN\n\nStatus: disconnected\", \"alt\": \"disconnected\"}"
fi
