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
	    echo -e " $hdd "
    }
##############################
#	    RAM
##############################

mem() {
	mem="$(free -h | awk '/Mem:/ {printf $3 "/" $2}')"
	echo -e " $mem "
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
		      echo -e " $cpu% "
	      }
##############################
#	    VOLUME
##############################

vol() {
	vol="$(amixer -D pulse get Master | awk -F'[][]' 'END{ print $4":"$2 }')"
	echo -e " $vol "
}
##############################
#	    Packages
##############################

pkgs() {
	pkgs="$(apt-mark showmanual | wc -l)"
	echo -e " $pkgs "
}
##############################
#	    UPGRADES
##############################

upgrades() {
	upgrades="$(aptitude search '~U' | wc -l)"
	echo -e " $upgrades "
}
##############################
#	    VPN
##############################

vpn() {
	vpn="$(ip a | grep tun0 | grep inet | wc -l)"
	echo -e " $vpn "
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
#    echo "+@fg=5;$(cpu) +@fg=0;| +@fg=2;$(mem) +@fg=0;| +@fg=4;$(pkgs) +@fg=0;| +@fg=1;$(hdd) +@fg=0;| +@fg=3;$(vpn)+@fg=0;| +@fg=1;$(vol) +@fg=0;|+@fg=2; $(weather) $(temp)   +@fg=0;"
	#This bar has icons and requires font-awesome package to be installed and declared as a secondary font in spectrwm.config
    echo "+@fn=1; +@fn=0;$(cpu) |  +@fn=1; +@fn=0;$(mem) |  +@fn=1;+@fn=0;$(pkgs) |  +@fn=1;+@fn=0;$(upgrades) |   +@fn=1;+@fn=0;$(hdd) | VPN  +@fn=1;+@fn=0;$(vpn) |  +@fn=1;+@fn=0;$(vol) | $(weather) $(temp)"
		sleep $SLEEP_SEC
		done


