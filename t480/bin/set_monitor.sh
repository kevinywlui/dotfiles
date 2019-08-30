#! /usr/bin/bash

ext_monitor_status=$(xrandr | grep ^DP-1 | cut -d ' ' -f 2)
if [[ $ext_monitor_status == "connected" ]]; then
        ~/.screenlayout/home_monitor.sh
fi
