#!/usr/bin/env bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch top and bottom config on all monitors

# See https://github.com/polybar/polybar/issues/763
for m in $(polybar --list-monitors | cut -d":" -f1); do
  if [[ $1 == "--timeless" ]];
  then
    echo "doing timeless"
    MONITOR=$m polybar top -c ~/.config/polybar/config-top-timeless.ini &
  else
    MONITOR=$m polybar top -c ~/.config/polybar/config-top.ini &
  fi
  
  MONITOR=$m polybar bottom -c ~/.config/polybar/config-bottom.ini &
done
