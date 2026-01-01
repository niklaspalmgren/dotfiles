#!/bin/bash
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/waybar"
CACHE_FILE="$CACHE_DIR/weather-cache"
CACHE_TIME=1800  # 30 min in seconds

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Check if cache exists and is fresh
if [ -f "$CACHE_FILE" ]; then
    cache_age=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE")))
    
    if [ $cache_age -lt $CACHE_TIME ]; then
        # Cache is fresh, use it
        cat "$CACHE_FILE"
        exit 0
    fi
fi

# Cache is missing or stale, fetch new weather
weather=$(timeout 5 curl -s 'wttr.in/?format=%c%20%t' 2>/dev/null | sed 's/  */ /g')

if [ -n "$weather" ]; then
    # Save to cache if we got a response
    echo "$weather" > "$CACHE_FILE"
    echo "$weather"
elif [ -f "$CACHE_FILE" ]; then
    # Use old cache if curl failed
    cat "$CACHE_FILE"
else
    # Fallback if neither new nor cached data exists
    echo "weather unavailabl"
fi
