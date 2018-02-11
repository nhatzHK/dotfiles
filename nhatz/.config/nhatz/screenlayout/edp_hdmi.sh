#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output HDMI2 --mode 1440x900 --pos 1920x0 --rotate normal --output HDMI1 --off --output DP2 --off

xset -dpms s 0 0
