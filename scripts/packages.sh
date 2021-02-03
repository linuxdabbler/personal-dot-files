#!/bin/bash
# icons depend on nerdfonts being installed
pkgs() {
    pakgs="$(dpkg -l | grep -c ^i)"
    echo -e " $pakgs"
}
echo " $(pkgs)"
