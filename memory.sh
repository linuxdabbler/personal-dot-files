#!/bin/bash
#icons depend on nerdfonts being installed
mem() {
used="$(free | grep Mem: | awk '{print $3}')"
total="$(free | grep Mem: | awk '{print $2}')"

#totalh="$(free -h | grep Mem: | awk '{print $2}' | sed 's/Gi/G/')"

ram="$(( 200 * $used/$total - 100 * $used/$total ))% "

echo $ram
}

echo " $(mem)"

case $BLOCK_BUTTON in
    1) notify-send "RAM hogs" "$(ps axch -o cmd:15,%mem --sort=-%mem | head)";;
    2) setsid -f st -e htop ;;
    3) notify-send "/usr/local/bin/memory.sh" ;;
esac
