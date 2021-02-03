#!/bin/bash
# icons depend on nerdfonts being installed
cpu() {
      read cpu a b c previdle rest < /proc/stat
        prevtotal=$((a+b+c+previdle))
          sleep 0.5
            read cpu a b c idle rest < /proc/stat
          total=$((a+b+c+idle))
            cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
              echo -e "  $cpu%"
          }
echo " $(cpu)"

case $BLOCK_BUTTON in
	1) notify-send "CPU hogs" "$(ps axch -o cmd:15,%cpu --sort=-%cpu | sed 11q)" ;;
	2) setsid -f st -e htop ;;
	3) notfy-send "/usr/local/bin/cpu.sh" ;;
esac

