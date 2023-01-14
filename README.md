# env

This is my environment setup for zsh + tmux + vim.
Its purpose is to automatically install all the utilities and tools on a fresh installed or existing linux work machine.

## Configuration:

zsh: 
    - it is [oh-my-zsh](https://ohmyz.sh/) + [powerlevel10k](https://github.com/romkatv/powerlevel10k) as the theme. Custom config of powerlevel10k in zsh.

tmux:
    -  [Oh my tmux!](https://github.com/gpakosz/.tmux) configuration.
    -
vim:
    - [vim-plug](https://github.com/junegunn/vim-plug) as plugin manager, list of plugins in vim subfolder.
vim:
    - Vim plugins and install scripts
    - vim dotfiles
env:
    - Scripts for environment setup (prompt, shell environment ...)


Tips:

For corporate proxy, please provide this setting in git to enable plugins download
 - git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:port
    - proxy.server and port can be found with netstat command as described in the folowing
      > netstate -an | grep EST
- You can also unset or check the current http.proxy
   - git config --global --get http.proxy 
   - git config --global --unset http.proxy 

Solarized color for cygwin:
 - For Cygwin env please follow this article http://randomartifacts.blogspot.fr/2012/10/a-proper-cygwin-environment.html to setup solarized color into mintty.

