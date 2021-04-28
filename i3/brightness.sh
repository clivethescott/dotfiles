#!/bin/sh
display=$(xrandr -q | grep ' connected' | head -n 1 | cut -d ' ' -f1)
xrandr --output $display --brightness $1
 
