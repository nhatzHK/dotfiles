#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1366x768 --pos 1360x0 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --mode 1360x768 --pos 0x0 --rotate normal --output DP2 --off

xset -dpms s 0 0
