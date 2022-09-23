#sequans aliases
alias cartman='ssh -Y mkourouma@cartman.fr.sequans.com'
alias cartman2='ssh -X mkourouma@cartman.fr.sequans.com'
# disable exiting a shell with CTRL+d
setopt IGNORE_EOF

#LS_COLORS=$LS_COLORS'ow=30;42:'


# sys troubleshouting
# show top processes by CPU usage and mem usage
alias pps='ps -eo uname:20,pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head ; ps -eo uname:20,pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
# monitor IO, by displaying process in waiting state (function to handle quotes/dquotes)
function ioo() { watch -n1 -d "ps axu | awk '{if (\$8==\"D\") {print \$0}}'" }

# grep
alias pygr='grep -r -n -i --include "*.py"'
alias cgr='grep -r -n -i --include "*.c" --include "*.h" --include "*.cpp" --include "*.cc"'

# SVN stuff
alias st='svn status -q --ignore-externals'
alias sdiff="svn diff | gvim -"

# Vim stuff
#alias pvim='gvim +"Project .vimprojects"'
#alias gvimrc="gvim -f ~/.gvimrc"
#alias -g V='| gvim -'

# Edith
alias dctv='/delivery/lib/scripts/edith -mapconfig /delivery/labo/OFDMA_26/Palladium/67/PXP/2_DOMAINS/Register/common/shiva_top_config_regs.xml -mapconfigsearch /delivery/labo/OFDMA_26/Palladium/67/PXP/2_DOMAINS/Register/xml +labTool +ddr +mxg -dump dump.txt +gppr'
alias dltv='/delivery/lib/scripts/lsd -mapconfig /delivery/labo/OFDMA_26/Palladium/67/PXP/2_DOMAINS/Register/common/shiva_top_config_regs.xml -mapconfigsearch /delivery/labo/OFDMA_26/Palladium/67/PXP/2_DOMAINS/Register/xml +labTool +ddr +mxg -dump dump.txt'
alias jctv='/delivery/lib/scripts/edith -mapconfig /delivery/labo/OFDMA_22/Palladium/70/0/Register/common/shiva_top_config_regs.xml -mapconfigsearch /delivery/labo/OFDMA_22/Palladium/70/0/Register/xml +labTool +ddr +mxg -dump dump.txt'
alias jltv='/delivery/lib/scripts/lsd -mapconfig /delivery/labo/OFDMA_22/Palladium/70/0/Register/common/shiva_top_config_regs.xml -mapconfigsearch /delivery/labo/OFDMA_22/Palladium/70/0/Register/xml'
alias ctv='/delivery/lib/scripts/edith -mapconfig /delivery/labo/OFDMA_15/mac_EP3SL340/mac_ulp_che_3110_12m288_VER_15_18_7067/Register/config_regs.xml +labTool +ddr +mxg -dump dump.txt'
alias ltv='/delivery/lib/scripts/lsd -mapconfig /delivery/labo/OFDMA_15/mac_EP3SL340/mac_ulp_che_3110_12m288_VER_15_18_7067/Register/config_regs.xml '

# MISC stuff
# edit and then source the zshrc
alias zshrc="vim -f ~/.zshrc ; echo 'sourcing the new zshrc !' ; source ~/.zshrc"
alias ipy="/usr/bin/env ipython"
alias h=history
# alias ll="ls -l"
alias tagit='ctags -R --extra=+q+f --exclude="tmp/*" --exclude="obj/*" --exclude="venv/*" --exclude="build/doc*" --exclude="notebooks/*"'
#alias ssh="TERM=xterm-256color ssh -X"
alias nob='cd /home/mkourouma/nobackup'
alias nobi='cd /home/mkourouma/nobackup/iceberg ; lrt'

# cd to Pi results, display the 10 more recent directories
alias nrt='cd /data/PI/testResults; ls -lrt | tail -n 10'
alias nrtl='cd /home/mkourouma/nobackup/coca; ls -lrt | tail -n 10'
alias lrt='ls -lrt'
alias lcd='cd "$(ls -dt */ | head -1)"'
alias lice="nobi; lcd; gvim iceberg.txt"
alias dobj='/opt/soft/toolchains/nds32be-elf-newlib-v3/bin/nds32be-elf-objdump tmp/elf/titanic-mips.elf -S'
alias guup='git stash && gup && git stash pop'

alias cad='source /home/mkourouma/.local/bin/cad_tool $1'
alias wbreboot='sudo /etc/init.d/winbind restart'

alias l1='okular "/home/mkourouma/nobackup/repos/dsp-docs/lte/specifications/layer1/ENG.PLT.DSP-SP-053-LTE_DORMOUSE_Layer_1_Specification.pdf"'

ifatal() {vim -c ':lvimgrep "FATAL ERROR" **/iceberg.txt'}
iabort() {vim -c ':lvimgrep "Abort" **/iceberg.txt'}

alias b='python engine/atomics/badger.py'

# start unitary test in iceberg dir easily
function utest() {
	ipython -c "run engine/unitTest/launchPyUnit.py -vv -f \"$1\""
}

function sci() {
	integer rev=$1
	integer rev2=$rev-1
	echo "svn log -r $rev -v |gvim - ; svn diff -r $rev2:$rev | gvim -"
	svn log -r $rev -v |gvim - ; svn diff -r $rev2:$rev | gvim -
}

# lice will open the last iceberg log, lice 2 thre previous one, lice 3 the one before etc ...
function lice() {
	cd /home/mkourouma/nobackup/iceberg
	cd "$(ls -dt */ | head -${1:=1} | tail -1)"
	vim iceberg.txt
}

function iceberg_prompt_info() {
	if [ -n "${ICEBERG_ROOT+x}" ]; then
		echo "${ZSH_THEME_ICEBERG_PROMPT_PREFIX}${ICEBERG_ROOT##*/}${ZSH_THEME_ICEBERG_PROMPT_SUFFIX}"
	fi
}

function scopeTagsGen() {
	WORKSPACEROOT=$HOME/nobackup/repos/gitlab
	if [ ! -d "$WORKSPACEROOT/$1" ]; then
		echo "scope and tags: missing project category"
		return 1
	elif [ ! -d "$WORKSPACEROOT/$1/$2" ]; then
		echo "scope and tags: missing project branch"
		return 1
	fi
	WORKSPACE=$1/$2
	WORKSPACEDIR=$WORKSPACEROOT/$1/$2
	SCOPETAGSDIR=$HOME/nobackup/scopetags/$WORKSPACE
	echo "Updating tags and cscope DB..."
	if [ ! -d "$SCOPETAGSDIR" ]; then
		mkdir -p "$SCOPETAGSDIR"
		cd $SCOPETAGSDIR
		echo "finding files..."
		find -H $WORKSPACEDIR -type f -and \( -name "*.c" -o -name "*.h" -o -name "*.cc" \) \
		-o -name '*.java' \
		-o -name '*properties' \
		-o -name '*.cpp' \
		-o -name '*.cc' \
		-o -name '*.hpp' \
		-o -name '*.py' > "$SCOPETAGSDIR/cscope.files"
		
		echo "Adding files to cscope db: $PWD/cscope.db ..."
		cscope -b -q -i "$SCOPETAGSDIR/cscope.files"
		# -b		build cross reference only
		# -q		Enable fast symbol lookup via an inverted index

		echo "Generating ctags files..."
		ctags -R -L $SCOPETAGSDIR/cscope.files --extra=+q+f \
		--exclude="tmp/*" \
		--exclude="obj/*" \
		--exclude="venv/*" \
		--exclude="build/doc*" \ 
		--exclude="notebooks/*" 
		# -L            Read the list of file names from the specified file.
		# --extra=+f    Also include entries for base filename. 
	fi

	export CSCOPE_DB=$SCOPETAGSDIR/cscope.out
	export CTAGS_DB=$SCOPETAGSDIR/tags
}

function coca() {
	COCA_ROOT=/home/mkourouma/nobackup/repos/gitlab/coca
	if [ "$#" -eq 0 ]; then
		category=""
		branch="master"
	fi
	if [ "$#" -eq 1 ]; then
		category=""
		branch=$1
	fi
	if [ "$#" -eq 2 ]; then
		category=$1
		branch=$2
	fi
	cd $COCA_ROOT/$category/$branch
	export ICEBERG_ROOT=$PWD
}

function titanic_prompt_info() {
	if [ -n "${TITANIC_ROOT+x}" ]; then
		echo "${ZSH_THEME_TITANIC_PROMPT_PREFIX}${TITANIC_ROOT##*/}${ZSH_THEME_TITANIC_PROMPT_SUFFIX}"
	fi
}

function lite() {
	LITE_ROOT=/home/mkourouma/nobackup/repos/gitlab/lite
	if [ "$#" -eq 0 ]; then
		category=""
		branch="catm"
	fi
	if [ "$#" -eq 1 ]; then
		category=""
		branch=$1
	fi
	if [ "$#" -eq 2 ]; then
		category=$1
		branch=$2
	fi
	cd $LITE_ROOT/$category/$branch
}

function pepsi() {
	COCA_ROOT=/home/mkourouma/nobackup/repos/gitlab/pepsi
	if [ "$#" -eq 0 ]; then
		category=""
		branch="master"
	fi
	if [ "$#" -eq 1 ]; then
		category=""
		branch=$1
	fi
	if [ "$#" -eq 2 ]; then
		category=$1
		branch=$2
	fi
	cd $COCA_ROOT/$category/$branch
	export ICEBERG_ROOT=$PWD
}

function tv() {
    TV_ROOT=/home/mkourouma/nobackup/repos/gitlab/tv
    if [ "$#" -eq 0 ]; then
        category=""
        branch="tv"
    fi

    cd $TV_ROOT/$category/$branch
}

