#!/bin/sh

# cat out Xresources file into ~/.Xdefaults to get my urxvt theme
cat Xresources >> ~/.Xdefaults

# Make baraction.sh executable
chmod +x baraction.sh

# copy my baraction script into the config folder for spectrwm to call it up from the config file
cp baraction.sh ~/.config/

# Make a backup of the current config file if there is one, or create a default one to fall back to in the ~/.config directory
cp ~/.spectrwm.conf ~/.config/spectrwm.conf.bak || sudo cat /etc/spectrwm.conf > ~/.config/spectrwm.conf.default && sudo cat /usr/share/doc/spectrwm/examples/spectrwm_us.conf >> ~/.config/spectrwm.conf.default 

# Cat out spectrwm.conf to the home folder
cat spectrwm.conf > ~/.spectrwm.conf

# Make scripts executable
chmod +x wal          #wallpaper changer
chmod +x lok          #blurry lockscreen
chmod +x louder       #increase volume
chmod +x quieter      #decrease volume
chmod +x hush         #mute

# Move scripts to $PATH
sudo mv wal /usr/local/bin/
sudo mv lok /usr/local/bin/
sudo mv louder /usr/local/bin/
sudo mv quieter /usr/local/bin/
sudo mv hush /usr/local/bin/

cp -r wallpapers ~/Pictures/ || mkdir ~/Pictures && cp -r wallpapers ~/Pictures

mkdir ~/Pictures/wallok/ & mkdir ~/Pictures/shots || exit

echo "  If you did not have spectrwm.conf file a copy of the default example config is in your ~/.config directory"
echo ""
echo "  If you already had a spectrwm.conf file, a backup of it is now in your ~/.config directory"  
echo ""
echo "  If you want to revert at any time, you can simply cat out the backup or default config into ~/.spectrwm.conf and restart spectrwm"

