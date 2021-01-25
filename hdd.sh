#!/bin/bash
#icons depend on nerdfonts being installed
hdd() {
      hdd="$(df -h /home | grep /dev | awk '{print $4}' | sed 's/G/Gb/')"
        echo -e " $hdd"
    }
echo "ﴤ $(hdd)"

case $BUTTON in
    1) notify-send "fstab directories" "$(df -h | sed '/^u\|^t/d' | awk '{print $6" "$2" "$4" "$5}' | column -t -s" ")"
    3) notify-send "/usr/local/bin/hdd.sh"
esac
