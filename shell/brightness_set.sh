#!/bin/sh
display=$(xrandr --query | grep ' connected' | head -n 1 | cut -d ' ' -f1)
xrandr --output $display --brightness $1
notify-send "Brightness set to $percent%"
