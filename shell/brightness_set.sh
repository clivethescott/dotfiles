#!/bin/sh
display=$(xrandr --query | grep ' connected' | head -n 1 | cut -d ' ' -f1)
xrandr --output $display --brightness $1
cur_bright=$(xrandr --current --verbose | grep Brightness | cut -d ' ' -f2)
percent=$(echo "$cur_bright * 100" | bc | sed 's/\.00$//')
notify-send "Brightness set to $percent%"
