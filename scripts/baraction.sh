#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude.
# Tested on: Debian Buster(with newest spectrwm built from source), Debian Bullseye, Devuan Chimaera, Devuan Ceres
# This config can be found on github.com/linuxdabbler

hostname="${HOSTNAME:-${hostname:-$(hostname)}}"

##############################
#	    DISK
##############################

hdd() {
	  hdd="$(df -h /home | grep /dev | awk '{print $3 " / " $5}')"
        echo "ﴤ $hdd"
    }
##############################
#	    RAM
##############################

mem() {
used="$(free | grep Mem: | awk '{print $3}')"
total="$(free | grep Mem: | awk '{print $2}')"

totalh="$(free -h | grep Mem: | awk '{print $2}' | sed 's/Gi/G/')"

ram="$(( 200 * $used/$total - 100 * $used/$total ))% / $totalh "

echo "  $ram"
}
##############################
#	    CPU
##############################

cpu() {
	  read cpu a b c previdle rest < /proc/stat
	    prevtotal=$((a+b+c+previdle))
	      sleep 0.5
	        read cpu a b c idle rest < /proc/stat
		  total=$((a+b+c+idle))
		    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
            echo " $cpu%"
	      }
##############################
#	    VOLUME
##############################

vol() {
    VOLONOFF="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $6}')"
    VOL="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $5}')"

    VOLICON="  "
    MUTEICON=" 婢 "

    if [ "$VOLONOFF" = "on" ]; then
        echo "$VOLICON $VOL"
    else
        echo "$MUTEICON"
    fi
}
##############################
#	    Packages
##############################

pkgs() {
	pkgs="$(dpkg -l | grep -c ^i)"
	echo " $pkgs"
}
##############################
#	    UPGRADES
##############################

upgrades(){
	upgrades="$(aptitude search '~U' | wc -l)"
	echo " $upgrades"
}
##############################
#	    NETWORK
##############################

network() {
wire="$(ip a | grep enp | grep inet | wc -l)"
wifi="$(ip a | grep wlan | grep inet | wc -l)"

if [ $wire = 1 ]; then
    echo "  $(hostname -I | awk '{print $1}')"
elif [ $wifi = 1 ]; then
    echo "  $(hostname -I | awk '{print $1}')"
else
    echo "睊"
fi
}

vpn() {
    state="$(ip a | grep tun0 | grep inet | wc -l)"

if [ $state = 1 ]; then
    echo "ﱾ"
else
    echo ""
fi
}

## WEATHER

weather=$(cat ~/.config/weather.txt | sed 25q | grep value | awk '{print $2 $3}' | sed 's/\"//g')
temp=$(cat ~/.config/weather.txt | grep temp_F | awk '{print $2}' | sed 's/\"//g' | sed 's/,//')

nocloud="盛"
cloud=""
rain=""
storm=""
lotempicon="  "
midtempicon="  "
hitempicon="  "

#print weather info

TEMP() {
if [ "$temp" -gt 80 ]; then
	echo $hitempicon $temp F
elif [ "$temp" -ge 50 ] && [ "$temp" -le 79 ]; then
	echo $midtempicon $temp F
elif [ "$temp" -le 49]; then
	echo $lotempicon $temp F
fi
}

WEATHER () {
if [[ "$weather" = "Clear" ]] || [[ "$weather" = "Sunny" ]]; then
	echo "$nocloud $weather"
else
	echo "$cloud $weather"
fi
}

## BATTERY
#bat() {
#batstat="$(cat /sys/class/power_supply/BAT0/status)"
#battery="$(cat /sys/class/power_supply/BAT0/capacity)"
#    if [ $batstat = 'Unknown' ]; then
#    batstat=""
#    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
#    batstat=""
#    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
#    batstat=""
#    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
#    batstat=""
#    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
#    batstat=""
#    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
#    batstat=""
#    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
#    batstat=""
#fi
#
#echo "$batstat  $battery %"
#}

      SLEEP_SEC=2
      #loops forever outputting a line every SLEEP_SEC secs
      while :; do
          #echo "$(cpu) | $(mem) | $(pkgs) | $(upgrades) | $(hdd) | $(vpn) $(network) | $(vol) | $(WEATHER) $(TEMP) "
          echo "+@bg=1; +@fg=0; $(cpu)  $(mem) +@bg=2; +@fg=1; $(pkgs)  $(upgrades) +@bg=3; $(hdd) +@bg=4; $(vpn) $(network) +@bg=5; $(vol) +@bg=6; $(WEATHER) $(TEMP) +@bg=1;+@fg=0;"
		sleep $SLEEP_SEC
		done
