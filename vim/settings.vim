"===================================================================================
"  FILE:  		 settings.vim
"  DESCRIPTION:  this file contains my personal vim settings
"  AUTHOR:  	 M. KOUROUMA
"  CREATED:  	 04.02.2022
"===================================================================================
"
"*****************************
"	GENERAL SETTINGS
"*****************************
"
"
" language-dependent indenting.
"
syntax  on  				" Switch syntax highlighting on.
"
"
"*******************************
"	 VARIOUS SETTINGS
"*******************************
"
"
set shiftwidth=4					" control how many columns text is indented with the reindent operations (<< and >>)
set tabstop=4						" how many columns a tab counts for (when using tab spaced)
set noexpandtab    					" Use tab for tabulation, not spaces
"set autoindent                  	" copy indent from current line
set autoread                    	" read open files again when changed outside Vim
set autowrite                   	" write a modified buffer on each :next , ...
set backspace=indent,eol,start  	" backspacing over everything in insert mode
set backup                      	" keep a backup file
set backupdir=~/.vim/tmp//,.        " backup file into separate folder
"set directory=~/.vim/tmp//,.        " save swp file to separate folder
set browsedir=current           	" which directory to use for the file browser
set complete+=k                 	" scan the files given with the 'dictionary' option
set encoding=utf-8					" Usually necessary to show unicode glyphs.
set history=50                  	" keep 50 lines of command line history
set hlsearch                    	" highlight the last used search pattern
set incsearch                   	" do incremental searching
set listchars=tab:>.,eol:\$     	" strings to use in 'list' mode
set laststatus=2					" always show the statusline.
set mouse=a                     	" enable the use of the mouse
set nowrap                      	" do not wrap lines
set number							" enable line numbering
set popt=left:8pc,right:3pc     	" print options
set ruler                       	" show the cursor position all the time
set showmatch						" show match in current file
set showcmd                     	" display incomplete commands
set t_Co=256						" enable 256 color in vim.
set ttyfast							" the current terminal is a fast terminal (to do more stuff at once)
set updatetime=1000					" Update time of many VIM things.(reasonable value)
set undofile						" save undo's file closes
set undodir=$HOME/.vim/undo			" where to save undo histories
set undolevels=1000					" how many undo is possible
set undoreload=1000					" number of lines to save for undo
set visualbell                 		" visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ 	" wildmenu: ignore these extensions
set wildmenu                    	" command-line completion in an enhanced mode
"
" show trailing whitespaces with a red bar
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
filetype plugin on
"
"
" GENERAL CONFIGURATION
let mapleader=','			" change the leader key to colon. Much easier
"
