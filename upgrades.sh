#!/bin/bash
# icons depend on nerdfonts being installed
upgrades () {
    upgrds="$(aptitude search '~U' | wc -l)"
    echo " $upgrds"
}
echo " $(upgrades)"

case $BLOCK_BUTTON in
    1) notify-send "Availible Upgrades" "$(apt list --upgradable)" ;;
    2) setsid -f "st -e apt list --upgradable" ;;
    3) notify-send "/usr/local/bin/upgrades.sh";;
esac

