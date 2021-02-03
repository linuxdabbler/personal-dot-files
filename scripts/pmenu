#!/bin/bash

DMENU='dmenu -i -l 4'
choice=$(echo -e "logout\nquit-pmenu" | $DMENU)

case "$choice" in
	logout) pkill dwm ;;
	quit-pmenu) exit 0 ;;
esac
