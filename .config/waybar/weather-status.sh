#!/bin/bash

readonly LOCATION="Höör"
readonly LAT="55.9372"
readonly LON="13.5422"
readonly CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/waybar"
readonly CACHE_FILE="$CACHE_DIR/weather-cache"
readonly CACHE_TTL=1800  # 30 minutes
readonly WEATHER_URL="https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/$LON/lat/$LAT/data.json"
readonly TIMEOUT=5

mkdir -p "$CACHE_DIR"

get_weather_icon() {
    case "$1" in
        1) echo "☀️" ;;   # Clear sky
        2) echo "🌤️" ;;   # Nearly clear sky
        3) echo "🌤️" ;;   # Variable cloudiness
        4) echo "🌥️" ;;   # Halfclear sky
        5) echo "☁️" ;;   # Cloudy sky
        6) echo "⛅" ;;   # Overcast
        7) echo "🌫️" ;;   # Fog
        8) echo "🌦️" ;;   # Light rain showers
        9) echo "🌧️" ;;   # Moderate rain showers
        10) echo "🌧️" ;;  # Heavy rain showers
        11) echo "⛈️" ;;  # Thunderstorm
        12) echo "🌨️" ;;  # Light sleet showers
        13) echo "🌨️" ;;  # Moderate sleet showers
        14) echo "🌨️" ;;  # Heavy sleet showers
        15) echo "🌨️" ;;  # Light snow showers
        16) echo "🌨️" ;;  # Moderate snow showers
        17) echo "🌨️" ;;  # Heavy snow showers
        18) echo "🌧️" ;;  # Light rain
        19) echo "🌧️" ;;  # Moderate rain
        20) echo "🌧️" ;;  # Heavy rain
        21) echo "⛈️" ;;  # Thunder
        22) echo "🌨️" ;;  # Light sleet
        23) echo "🌨️" ;;  # Moderate sleet
        24) echo "🌨️" ;;  # Heavy sleet
        25) echo "🌨️" ;;  # Light snowfall
        26) echo "🌨️" ;;  # Moderate snowfall
        27) echo "🌨️" ;;  # Heavy snowfall
        *) echo "🌡️" ;;   # Unknown
    esac
}

to_json() {
    local text="$1"
    local tooltip="$2"
    
    # Escape quotes and newlines for JSON
    text="${text//\"/\\\"}"
    tooltip="${tooltip//\"/\\\"}"
    tooltip="${tooltip//$'\n'/\\n}"
    
    printf '{"text":"%s","tooltip":"%s"}\n' "$text" "$tooltip"
}

is_cache_valid() {
    [[ -f "$CACHE_FILE" ]] || return 1
    
    local cache_age=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE") ))
    (( cache_age < CACHE_TTL ))
}

fetch_weather() {
    timeout "$TIMEOUT" curl -sf "$WEATHER_URL" 2>/dev/null
}

parse_weather() {
    local json_data="$1"
    
    local temp=$(echo "$json_data" | jq -r '.timeSeries[0].parameters[] | select(.name=="t") | .values[0]')
    local wsymb=$(echo "$json_data" | jq -r '.timeSeries[0].parameters[] | select(.name=="Wsymb2") | .values[0]')
    local wind=$(echo "$json_data" | jq -r '.timeSeries[0].parameters[] | select(.name=="ws") | .values[0]')
    local humidity=$(echo "$json_data" | jq -r '.timeSeries[0].parameters[] | select(.name=="r") | .values[0]')
    local precip=$(echo "$json_data" | jq -r '.timeSeries[0].parameters[] | select(.name=="pcat") | .values[0]')
    
    local icon=$(get_weather_icon "$wsymb")
    
    temp=$(printf "%.0f" "$temp")
    
    local short_text="$icon ${temp}°C"
    
    local tooltip="$LOCATION

Current:
  Temprature: ${temp}°C
  Wind: ${wind} m/s
  Humidity: ${humidity}%
  
Following hours:"
    
    for i in {1..6}; do
        local time=$(echo "$json_data" | jq -r ".timeSeries[$i].validTime" | cut -d'T' -f2 | cut -d':' -f1-2)
        local t=$(echo "$json_data" | jq -r ".timeSeries[$i].parameters[] | select(.name==\"t\") | .values[0]")
        local ws=$(echo "$json_data" | jq -r ".timeSeries[$i].parameters[] | select(.name==\"Wsymb2\") | .values[0]")
        local ic=$(get_weather_icon "$ws")
        t=$(printf "%.0f" "$t")
        tooltip="$tooltip
  $time: $ic ${t}°C"
    done
    
    to_json "$short_text" "$tooltip"
}

main() {
    if ! command -v jq &> /dev/null; then
        to_json "jq missing" "Install jq to use this script"
        return 1
    fi
    
    if is_cache_valid; then
        cat "$CACHE_FILE"
        return 0
    fi
    
    local weather_data
    weather_data=$(fetch_weather)
    
    if [[ -n "$weather_data" ]]; then
        local json
        json=$(parse_weather "$weather_data")
        
        echo "$json" | tee "$CACHE_FILE"
    elif [[ -f "$CACHE_FILE" ]]; then
        cat "$CACHE_FILE"
    else
        to_json "weather unavailavle" "could not fetch weather from SMHI"
    fi
}

main
