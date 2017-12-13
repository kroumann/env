# env-configs

env-configs contains all the configurations files for my work station on linux machine. 
Its purpose is to automatically install all the utilities and tools on a fresh installed or existing linux machine.

Script contain:

bin:
    - Contains script for xilinx's tools configuration and launch.
    -
elnx:
    - Contains utilities scripts for embedded linux development.
vim:
    - Vim plugins and install scripts
    - vim dotfiles
env:
    - Scripts for environment setup (prompt, shell environment ...)


Requirements:

vim :
Install Vundle package manager that you can find here: https://github.com/VundleVim/Vundle.vim
For corporate proxy, please provide this setting in git to enable plugins download
 - git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:port
    - proxy.server and port can be found with netstat command as described in the folowing  
      > netstate -an | grep EST
- You can also unset or check the current http.proxy
   - git config --global --get http.proxy 
   - git config --global --unset http.proxy 


For Cygwin env please follow this article http://randomartifacts.blogspot.fr/2012/10/a-proper-cygwin-environment.html to setup 
solarized color into mintty.

Create a .vimrc has a symbolic link file : - ln -sf ~/path/to/MyEnvConfig/vimrc ~/.vimrc (recommanded, but you can just copy this file to your home folder)
