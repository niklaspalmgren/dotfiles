#!/bin/bash

# Get today's agenda
today_agenda=$(gcalcli agenda --nostarted --tsv 2>/dev/null | tail -n +2 | grep "^$(date +%Y-%m-%d)")

if [ -z "$today_agenda" ]; then
    echo '{"text": "", "class": "no-events", "tooltip": "No events today"}'
    exit 0
fi

# Get next event (first line)
next_event=$(echo "$today_agenda" | head -1)
time=$(echo "$next_event" | cut -f2)
title=$(echo "$next_event" | cut -f5 | cut -c1-25)

# Create tooltip from raw TSV
tooltip=$(echo "$today_agenda")

echo "{\"text\": \"󰃭 $time $title\", \"tooltip\": \"$tooltip\"}"
