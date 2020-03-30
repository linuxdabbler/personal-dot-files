#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude.
# Tested on: Debian 10
#

print_date() {
	# The date is printed to the status bar by default.
	# To print the date through this script, set clock_enabled to 0
	# in spectrwm.conf.  Uncomment "print_date" below.
#	FORMAT="%a %b %d %R %Z %Y"
	FORMAT="   %a %b %d       %R"
	DATE=`date "+${FORMAT}"`
	echo -n "     ${DATE}     "
}

print_mem() {
#	MEM=`/usr/bin/free -m | grep ^Mem: | sed -E 's/ +/ /g' | cut -d ' ' -f4`
	MEM=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
	echo -n "| Free RAM:  ${MEM}   | "
}

_print_cpu() {
	printf "CPU: %3d%% User %3d%% Nice %3d%% Sys %3d%% Idle  " $1 $2 $3 $6
}

print_cpu() {
	OUT=""
	# Remove the decimal part from all the percentages.
	while [ "${1}x" != "x" ]; do
		OUT="$OUT `echo "${1}" | cut -d '.' -f1`"
		shift;
	done
	_print_cpu $OUT
}

print_cpuspeed() {
	CPU_SPEED=`/usr/bin/lscpu | grep '^CPU MHz:' | sed -E 's/ +/ /g' | cut -d ' ' -f3 | cut -d '.' -f1`
	printf "CPU speed: %4d MHz  " $CPU_SPEED
}

print_packages() {
	Packages="$(apt list --installed | wc -l || pacaman -Q | wc-l)"
	
	printf "  Packages:  $Packages  | "
}

print_upgrades() {
	Upgrades="$(aptitude search '~U' | wc -l || pacman -Qu)"

	printf "  Upgrades:  $Upgrades  | "
}


print_kernel() {

	kernel="$(uname -r | sed 's/-amd64//')"

	printf "  Kernel: $kernel  | "

}	

print_cputemp() {

	CPU="$(sensors | awk '/^Tctl:/ {print $2}')"

	printf "  CPU Temp:  $CPU | "

}

print_IP() {

	IP="$(hostname -I | awk '{print $1}')"

	printf "  LAN: $IP | "
}

print_vpn() {

	vpn="$(ip a | grep tun0 | grep inet | wc -l)"
	
	printf " VPN Connections: $vpn   | "
}
   

print_vol() {

	vol="$(amixer -D pulse get Master | grep Right | grep -o "[0-9]*%\|\[on\]|[off\]")"

	 echo -n " Vol:  $vol  | "
}


print_net() {

	net="$(cat /sys/class/net/enp6s0/operstate)"

	printf " Network $net  |  "
}

print_bat() {
	AC_STATUS="$3"
	BAT_STATUS="$6"
	# Most battery statuses fit into a single word, except "Not charging"
	# for which we need to have special handling.
	if [ "$BAT_STATUS" = "Not" ]; then
		BAT_STATUS="$BAT_STATUS $7"
		shift
	fi
	BAT_LEVEL="`echo "$7" | tr -d ','`"

	if [ "$AC_STATUS" != "" -o "$BAT_STATUS" != "" ]; then
		if [ "$BAT_STATUS" = "Discharging," ]; then
			echo -n "on battery ($BAT_LEVEL)"
		else
			case "$AC_STATUS" in
			on-line)
				AC_STRING="on AC: "
				;;
			*)
				AC_STRING=""
				;;
			esac
			case "$BAT_STATUS" in
			"")
				BAT_STRING="(no battery)"
				;;
			*harging,|Full,)
				BAT_STRING="(battery $BAT_LEVEL)"
				;;
			*)
				BAT_STRING="(battery unknown)"
				;;
			esac

			FULL="${AC_STRING}${BAT_STRING}"
			if [ "$FULL" != "" ]; then
				echo -n "$FULL"
			fi
		fi
	fi
}

# Cache the output of acpi(8), no need to call that every second.
ACPI_DATA=""
I=0
while :; do
	IOSTAT_DATA=`/usr/bin/iostat -c | grep '[0-9]$'`
	if [ $I -eq 0 ]; then
		ACPI_DATA=`/usr/bin/acpi -a 2>/dev/null; /usr/bin/acpi -b 2>/dev/null`
	fi
	print_mem
#	print_cpu $IOSTAT_DATA
#	print_cpuspeed
	print_cputemp
	print_packages
	print_upgrades
	print_kernel
	print_net
	print_vpn
	print_IP
	print_vol
	print_date
#	print_bat $ACPI_DATA
	echo ""
#	I=$(( ( ${I} + 1 ) % 11 ))
	sleep 1
done



