#!/bin/sh
min_bright=0.2
max_bright=1.0
display=$(xrandr --query | grep ' connected' | head -n 1 | cut -d ' ' -f1)
cur_bright=$(xrandr --current --verbose | grep Brightness | cut -d ' ' -f2)
new_bright=$(echo "$cur_bright + $1" | bc | sed 's/^\./0./')
less_than_max=$(echo "$new_bright < $max_bright" | bc)
greater_than_min=$(echo "$new_bright > $min_bright" | bc)
if [ $greater_than_min -eq 1 ] && [ $less_than_max -eq 1 ]; then
  xrandr --output $display --brightness $new_bright
fi
 
