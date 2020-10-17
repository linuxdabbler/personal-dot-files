#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude.
# Tested on: Debian Testing
# This config can be found on github.com/linuxdabbler

############################## 
#	    DISK
##############################

hdd() {
	  hdd="$(df -h /home | grep /dev | awk '{print $3 " / " $5}')"
	    echo -e " $hdd"
    }
##############################
#	    RAM
##############################

mem() {
	mem="$(free -h | awk '/Mem:/ {printf $3 "/" $2}')"
	echo -e " $mem"
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
		      echo -e "  $cpu%"
	      }
##############################
#	    VOLUME
##############################

vol() {
	vol="$(amixer -D pulse get Master | awk -F'[][]' 'END{ print $4":"$2 }')"
	echo -e " $vol"
}
##############################
#	    Packages
##############################

pkgs() {
	pkgs="$(apt list --installed | wc -l)"
	echo -e " $pkgs"
}
##############################
#	    UPGRADES
##############################

upgrades() {
	upgrades="$(aptitude search '~U' | wc -l)"
	echo -e " $upgrades"
}
##############################
#	    VPN
##############################

vpn() {
	vpn="$(ip a | grep tun0 | grep inet | wc -l)"
	echo -e " $vpn"
}
## WEATHER
weather() {
	wthr="$(sed 20q ~/.config/weather.txt | grep value | awk '{print $2 $3}' | sed 's/"//g')"
	echo " $wthr"
}

## TEMP
temp() {
	tmp="$(grep temp_F ~/.config/weather.txt | awk '{print $2}' | sed 's/"//g' | sed 's/,/ F/g')"
	echo " $tmp"
}


      SLEEP_SEC=2
      #loops forever outputting a line every SLEEP_SEC secs
      while :; do     
    echo "$(cpu)| $(mem)| $(pkgs)| $(hdd)|嬨 $(vpn)| $(vol)|$(weather) $(temp)|"
		sleep $SLEEP_SEC
		done

