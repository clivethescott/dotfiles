#!/bin/sh
cur_bright=$(xrandr --current --verbose | grep Brightness | cut -d ' ' -f2)
percent=$(echo "$cur_bright * 100" | bc | sed 's/\.00//')

 
