#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude.
# Tested on: Debian Testing
# This config can be found on github.com/linuxdabbler

############################## 
#	    DATE
##############################

date() {
	  date="$(date +"%a, %b %d %R")"
	    echo -e " $dte "
    }

############################## 
#	    DISK
##############################

hdd() {
	  hdd="$(df -h /home | grep /dev | awk '{print $3 " / " $5}')"
	    echo -e " HDD: $hdd "
    }
##############################
#	    RAM
##############################

mem() {
	mem="$(free -h | awk '/Mem:/ {printf $3 "/" $2}')"
	echo -e " Mem: $mem "
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
		      echo -e " CPU: $cpu% "
	      }
##############################
#	    VOLUME
##############################

vol() {
	vol="$(amixer -D pulse get Master | awk -F'[][]' 'END{ print $4":"$2 }')"
	echo -e " Volume $vol "
}
##############################
#	    Packages
##############################

pkgs() {
	pkgs="$(apt list --installed | wc -l)"
	echo -e " Packages: $pkgs "
}
##############################
#	    UPGRADES
##############################

upgrades() {
	upgrades="$(aptitude search '~U' | wc -l)"
	echo -e " Upgrades: $upgrades "
}
##############################
#	    VPN
##############################

vpn() {
	vpn="$(ip a | grep tun0 | grep inet | wc -l)"
	echo -e " VPN Connections: $vpn "
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


      SLEEP_SEC=1
      #loops forever outputting a line every SLEEP_SEC secs
      while :; do     
	#This bar is for spectrwm 3.3+
		echo "+@fg=5;$(cpu) +@fg=0;| +@fg=2;$(mem) +@fg=0;| +@fg=4;$(pkgs) +@fg=0;| +@fg=1;$(hdd) +@fg=0;| +@fg=3;$(vpn)+@fg=0;| +@fg=1;$(vol) +@fg=0;|"
	#This bar is for spectrwm 3.2 and lower
		#echo "$(cpu) | $(mem) | $(pkgs) | $(hdd) | $(vpn) | $(vol) | $(date)"
		sleep $SLEEP_SEC
		done



