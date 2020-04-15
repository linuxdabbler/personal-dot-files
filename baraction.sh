#!/bin/sh
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude.
# Tested on: Debian 10
#

print_date() {
	# The date is printed to the status bar by default.
	# To print the date through this script, set clock_enabled to 0
	# in spectrwm.conf.  Uncomment "print_date" below.
	FORMAT="   %a %b %d       %R"
	DATE=`date "+${FORMAT}"`
	echo -n "     ${DATE}     "
}

print_mem() {
	MEM=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
	echo -n "Free RAM: ${MEM} | "
}

print_packages() {
	Packages="$(apt list --installed | wc -l || pacaman -Q | wc-l)"
	
	printf " Packages: $Packages | "
}

print_upgrades() {
	Upgrades="$(aptitude search '~U' | wc -l || pacman -Qu)"

	printf " Upgrades: $Upgrades | "
}


print_kernel() {

	kernel="$(uname -r | sed 's/-amd64//')"

	printf " Kernel: $kernel | "

}	

print_cputemp() {

	CPU="$(sensors | awk '/^Tctl:/ {print $2}')"

	printf " CPU Temp: $CPU | "

}

print_IP() {

	IP="$(hostname -I | awk '{print $1}')"

	printf " LAN: $IP | "
}

print_vpn() {

	vpn="$(ip a | grep tun0 | grep inet | wc -l)"
	
	printf " VPN Connections: $vpn | "
}
   

print_vol() {

	vol="$(amixer -D pulse get Master | grep Right | grep -o "[0-9]*%\|\[on\]|[off\]")"

	 echo -n " Vol:  $vol | "
}


print_net() {

	net="$(cat /sys/class/net/enp6s0/operstate)"

	printf " Network $net | "
}

while :; do
	print_mem
	print_cputemp
	print_packages
	print_upgrades
	print_kernel
	print_net
	print_vpn
	print_IP
	print_vol
	print_date
	echo ""
	sleep 1
done


