#!/bin/bash

pkgs() {
    pakgs="$(dpkg -l | grep -c ^i)"
    echo -e " $pakgs"
}
echo " $(pkgs)"
