#!/usr/bin/env bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2

if [ $1 == "--timeless" ];
then
  echo "doing timeless"
  polybar top -c ~/.config/polybar/config-top-timeless.ini &
else
  polybar top -c ~/.config/polybar/config-top.ini &
fi

polybar bottom -c ~/.config/polybar/config-bottom.ini &
