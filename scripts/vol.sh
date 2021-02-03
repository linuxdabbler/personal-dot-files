#!/bin/bash

VOLONOFF="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $6}')"
VOL="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $5}')"

VOLICON=""
MUTEICON="婢"


if [ "$VOLONOFF" = "on" ]; then
	echo "$VOLICON $VOL"
else
	echo "$MUTEICON"
fi
