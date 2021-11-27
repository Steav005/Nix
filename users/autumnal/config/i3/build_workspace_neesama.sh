#!/usr/bin/env bash

# Append Layout
i3-msg "workspace 7; append_layout ~/.config/i3/workspace-7-neesama.json"

alacritty &

# Wait for Internet but maximum 15 seconds
counter=0
while ! timeout 0.2 ping -c 1 -n 1.1.1.1 &> /dev/null
do
    sleep 1s
    counter=$((counter + 1))
    if (( counter > 15 )); then
        exit 1
    fi
done

spotify &
mattermost-desktop &
telegram-desktop &
element-desktop &
rocketchat-desktop &
discordcanary &