# env

This is my dotfiles and installation scripts for zsh + tmux + vim.
Its purpose is to automatically install all the utilities and tools on a fresh installed or existing linux work machine.

- [Installation](#installation)
- [Configuration](#configuration)


## Installation

This scripts use [dotbot](https://github.com/anishathalye/dotbot) to ease the installation of dotfiles.

1. clone this repos:`git clone https://github.com/kroumann/env ~/.env`
2. `cd ~/.env` and `./install.sh` to install.
3. Done, but you can fine tune some files and configuration from here.

## Configuration:

*zsh*:

- it is [oh-my-zsh](https://ohmyz.sh/) + [powerlevel10k](https://github.com/romkatv/powerlevel10k) as the theme. Custom config of powerlevel10k in zsh.
  You can also install font requirements for powerlevel10k.

*tmux*:

-  [Oh my tmux!](https://github.com/gpakosz/.tmux) configuration.

*vim*:

- [vim-plug](https://github.com/junegunn/vim-plug) as plugin manager, list of plugins in vim subfolder.


**Tips**:

For corporate proxy, please provide this setting in git to enable plugins download
 - git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:port
    - proxy.server and port can be found with netstat command as described in the folowing
      > netstate -an | grep EST
- You can also unset or check the current http.proxy
   - git config --global --get http.proxy 
   - git config --global --unset http.proxy 

Solarized color for cygwin:
 - For Cygwin env please follow this article http://randomartifacts.blogspot.fr/2012/10/a-proper-cygwin-environment.html to setup solarized color into mintty.

