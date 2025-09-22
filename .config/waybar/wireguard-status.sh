#!/bin/bash

interfaces=$(wg show interfaces 2>/dev/null)

if [[ -n $interfaces ]]; then
    echo "{\"text\": \"󰦝\", \"class\": \"connected\", \"tooltip\": \"Connected to VPN $interfaces\", \"alt\": \"connected\"}"
else
    echo "{\"text\": \"󰦝\", \"class\": \"disconnected\", \"alt\": \"disconnected\"}"
fi
