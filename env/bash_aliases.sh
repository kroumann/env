#!/bin/bash

# Common aliases
alias apt-get="sudo apt-get"
alias update="apt-get update && apt-get upgrade"
alias bashrc="nano ~/.bashrc && source ~/.bashrc"
alias fstab="sudo nano /etc/fstab"
alias netI="sudo nano /etc/network/interfaces"

alias ls="ls --color=auto"
alias ll="ls -lhA"
alias lsl="ls -lhFA | less"
alias cd..="cd .."
alias histg="history | grep"

alias vi="vim"
alias edit="gvim"

#remote com alias
alias com="minicom -w"

#search functions
function ufind { find . -name '*.[chS]' | xargs egrep -n "$1"; }

# System Aliases
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"
alias ps="ps auxf"
# make process searchable (e.g: psg bash)
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -pv"
# This priceless function is from xvoland on github
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}


