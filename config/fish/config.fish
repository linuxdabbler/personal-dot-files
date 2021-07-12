#     __   ___
#    / /  / _ \       Linux Dabbler
#   / /__/ // /       http://youtube.com/c/linuxdabbler
#  /____/____/        http://github.com/linuxdabbler
#
# My fish shell config.  Nothing fancy, but I like it.

set -U fish_user_paths $fish_user_paths $HOME/.local/bin
set -U fish_user_paths $fish_user_paths $HOME/bin

set fish_greeting           # Turns off the intro message when pulling up fish shell
set TERM "xterm-256color"   # Sets the terminal type
set EDITOR "nvim"            # Sets $EDITOR to vim
set VISUAL "geany"          # Sets $VISUAL to geany for GUI Editor

### VIM mode keybindings ###
function fish_user_key_bindings
    fish_vi_key_bindings
end

# End of VIM Keybindings

### Prompt configuration ###
function fish_prompt --description 'Screen Savvy prompt'
    if test -z "$WINDOW"
        printf '%s%s@%s%s%s%s%s> ' (set_color yellow) $USER (set_color purple) (prompt_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    else
        printf '%s%s@%s%s%s(%s)%s%s%s> ' (set_color yellow) $USER (set_color purple) (prompt_hostname) (set_color white) (echo $WINDOW) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    end
end

#  End of Prompt configuration

### CUSTOM FUNCTIONS ###

# Custom Function for a sudo !! replacement

function sudo --description "replacement for 'sudo !!' command to run last command using sudo"
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

# Endo of sudo !! function

# Custom function for line counting
function line-count
    wc -l | string trim
end

# Custom function for counting installed programs
function count-installed
    dpkg -l | grep -c '^ii' | string trim
end

# Custom function for listing installed programs
function list-installed
    apt list --installed | string trim
end

# Custom function for listing ram hogs
function memhogs
    ps axh -o cmd:15,%mem --sort=-%mem | head | string trim
end

# Custom function for listing cpu hogs
function cpuhogs
    ps axh -o cmd:15,%cpu --sort=-%cpu | head
end

# Function to find resolutions of monitors
function resolution
    xrandr | grep \* | sed 's/59.95\*+//g'
end

# Function to print percent used hdd space of home folder
function hdd
    df -h /home | grep /dev | awk '{print $3 "/" $5}'
end

# Function to see available storage in home folder
function avail
    df -h /home | grep /dev/ | awk '{print $4}'
end

# Function to make apt search better
function aptsearch
    apt-cache search '' | sort | cut -d ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}'| xargs -r sudo apt install -y
end

### Abbreviations  ###

abbr sai sudo apt install'
abbr sainir sudo apt install --no-install-recommends'
abbr df 'df -h'
abbr free 'free -g'
abbr reboot 'sudo reboot'
abbr virtnetwork 'sudo virsh net-start default'
abbr h 'cd ~/'
abbr c 'clear'
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr v 'nvim'
abbr ll 'ls -l'
abbr la 'ls -A'
abbr ls. 'ls -A | egrep "^\."'
abbr merge 'xrdb -merge ~/.Xresources'
abbr q 'exit'
abbr d 'cd ~/Downloads'
abbr doc 'cd ~/Documents'
abbr grep 'grep --color=auto'
abbr egrep 'egrep --color=auto'
abbr fgrep 'fgrep --color=auto'
abbr cp 'cp -i'
abbr mv 'mv -i'
abbr rm 'rm -i'
abbr .c 'cd ~/.config'
abbr pk 'sudo pkill'
abbr vdwm 'cd ~/.local/src/dwm && vim config.def.h'
abbr vst 'cd ~/.local/src/st && vim config.def.h'
abbr nasbox 'ssh timelord@192.168.0.19'

dfetch
