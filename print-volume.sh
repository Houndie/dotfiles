#!/bin/bash

muted=$(pactl list sinks | grep Mute | awk '{print $2}')
if [ "$muted" == "yes" ]
then
   echo "M"
else
   pactl list sinks | grep "^\s*Volume" | awk '{print $5}'
fi
