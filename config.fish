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
set EDITOR "vim"            # Sets $EDITOR to vim
set VISUAL "geany"          # Sets $VISUAL to geany for GUI Editor

# VIM mode keybindings
function fish_user_key_bindings
    fish_vi_key_bindings
end

# End of VIM Keybindings

# Prompt configuration
function fish_prompt --description 'Screen Savvy prompt'
    if test -z "$WINDOW"
        printf '%s%s@%s%s%s%s%s> ' (set_color yellow) $USER (set_color purple) (prompt_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    else
        printf '%s%s@%s%s%s(%s)%s%s%s> ' (set_color yellow) $USER (set_color purple) (prompt_hostname) (set_color white) (echo $WINDOW) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    end
end

#  End of Prompt configuration

# Custom Function for a sudo !! replacement
function sudo --description "replacement for 'sudo !!' command to run last command using sudo"
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

# Endo of sudo !! function

# Aliases

alias df='df -h'
alias free='free -g'
alias memhogs='ps auxf | sort -nr -k 4 | head -10'
alias cpuhogs='ps auxf | sort -nr -k 3 | head -10'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown now'
alias virtnetwork='sudo virsh net-start default'
alias h='cd ~/'
alias ..='cd ..'
alias ...='cd ../..'
alias v='vim'
alias ll='ls -l'
alias la='ls -A'
alias ls.='ls -A | egrep "^\."'
alias merge='xrdb -merge ~/.Xresources'
alias q='exit'
alias d='cd ~/Downloads'
alias doc='cd ~/Documents'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias .c='cd ~/.config'
alias pk='sudo pkill'
alias nasbox='ssh timelord@192.168.0.19'

# Screen fetcher
dev-fetch
