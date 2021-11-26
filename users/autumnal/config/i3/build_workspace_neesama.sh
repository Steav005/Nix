#!/bin/bash

# Append Layout
i3-msg "workspace 7; append_layout ~/.config/i3/workspace-7-neesama.json"

alacritty &

#sleep 3s

spotify &
mattermost-desktop &
telegram-desktop &
element-desktop &
rocketchat-desktop &
discord-canary &