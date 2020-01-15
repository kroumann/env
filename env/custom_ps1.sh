
#!/bin/bash

# shorten a path in $1 to max of $2 characters, prepending a "..."
function __shortpath {
    if [[ ${#1} -gt $2 ]]; then
        len=$2+3
        echo "..."${1: -$len}
    else
        echo $1
    fi
}

# drops first portion of a path $1 if length is greater than $2
function __droppath {
    if [[ ${#1} -gt $2 ]]; then
        p=$1
        while [ ${#p} -gt $2 ]; do
            p="/"$(echo "$p"|cut -d"/" -f3-)
        done
        echo "..."$p
    else
        echo $1
    fi
}

# Configure `__git_ps1` to tell us as much as possible
export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_HIDE_IF_PWD_IGNORED=1


if [ "`id -u`" -eq 0 ]; then
    export PS1='\n[\[\033[31m\] $(__droppath "\w" 30)\[\e[0m\e[1;33m\]$(__git_ps1 " (%s)") \[\033[0m\]]\[\033[0m\]\n\[\033[1;36m\]\u@\h: \[\033[1;34m\]\$ \[\033[0m\]'
else
    export PS1='\n[\[\033[32m\] $(__droppath "\w" 30)\[\e[0m\e[1;33m\]$(__git_ps1 " (%s)") \[\033[0m\]]\[\033[0m\]\n\[\033[1;36m\]\u@\h: \[\033[1;34m\]\$ \[\033[0m\]'
#    export PS1='\n[\[\033[32m\] $(__droppath "\w" 30) \[\033[0m\]]\[\033[0m\]\n\[\033[1;36m\]\u@\h: \[\033[1;34m\]\$ \[\033[0m\]'
fi

# tmux patch for dynamic window title
# this requires: 'setw -g automatic-rename on' in your tmux.conf file 

# settitle() {
#    printf "\033k$1\033\\"
# }

# dynamic_window_title='${USER}@${PWD:${#PWD}<25?0:(-25)}'
# PROMPT_COMMAND='case $TERM in (screen*) eval prompt=$dynamic_window_title; settitle "$prompt"; esac'
#_________________

#export PS1= "\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$"
#export PS1="\n[\[\033[32m\] \w \[\033[0m\]]\[\033[0m\]\n\[\033[1;36m\]\u@\h: \[\033[1;34m\]\$ \[\033[0m\]"
#export PS1="\u@\h:\$ "
#export PS1="\e[0;31m[\u:\w]\$ \e[m" 
#export PS1="\u@\h[\w]\$"
#export PS1="\n[\[\033[31m\] \w \[\033[0m\]]\[\033[0m\]\n\[\033[1;36m\]\u@\h: \[\033[1;34m\]\# \[\033[0m\]"
