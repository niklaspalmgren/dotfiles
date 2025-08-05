#!/bin/bash

# Gå till workspace 5
hyprctl dispatch workspace 5
sleep 0.2

# Stäng alla fönster i workspace 5
hyprctl clients -j | jq -r '.[] | select(.workspace.id == 5) | .address' | xargs -I {} hyprctl dispatch closewindow address:{}

qutebrowser --target window https://hsb.datadoghq.eu/dashboard/br5-kie-ccd/team-frikoppla-prod?fromUser=false&refresh_mode=sliding&from_ts=1753252640134&to_ts=1753256240134&live=true &
qutebrowser --target window --basedir ~/.config/qutebrowser-hsb-servicenow https://hsb.service-now.com &
