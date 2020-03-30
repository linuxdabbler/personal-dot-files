#!/bin/sh

# cat out Xresources file into ~/.Xdefaults to get my urxvt theme
cat Xresources >> ~/.Xdefaults

# Make baraction.sh executable
chmod +x baraction.sh

# copy my baraction script into the config folder for spectrwm to call it up from the config file
cp baraction.sh ~/.config/

# Make a backup of the current config file if there is one, or create a default one to fall back to in the ~/.config directory
cp ~/.spectrwm.conf ~/.config/spectrwm.conf.bak || sudo cat /etc/spectrwm.conf > ~/.config/spectrwm.conf.bak && sudo cat /usr/share/doc/spectrwm/examples/spectrwm_us.conf >> ~/.config/spectrwm.conf.bak

# Cat out spectrwm.conf to the home folder
cat spectrwm.conf > ~/.spectrwm.conf

# Make scripts executable
chmod +x wal
chmod +x lok
chmod +x louder
chmod +x quieter
chmod +x hush

# Move wallok script to a directory in the default PATH
sudo mv wal /usr/local/bin/

cp -r wallpapers ~/Pictures/ || mkdir ~/Pictures && cp -r wallpapers ~/Pictures

mkdir ~/Pictures/wallok/ & mkdir ~/Pictures/shots || exit


