
"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  this file contains my personal configuration of vimrc
"  		 inspired from Fritz Mehner suggestion 
"       AUTHOR:  M. KOUROUMA 
"      CREATED:  09.09.2016
"===================================================================================
"
"*****************************
"	GENERAL SETTINGS
"*****************************
"
"" VIM 
set nocompatible			" Use Vim settings, rather then Vi settings.
					" This must be first, because it changes 
					" other options 
					" as a side effect.
"
"" VUNDLE  INITIALIZATION
set rtp+=~/.vim/bundle/Vundle.vim	" set the runtime path to include Vundle 
					" and initilize
call vundle#begin()			" alternatively, pass a path where vundle
					" should install plugins
					" call vundle#begin('~/some/path/here')
Plugin 'VundleVim/Vundle.vim'		" let vundle manage vundle, this is required

"" PLUGINS
Plugin 'Valloric/YouCompleteMe'		" autocompletion plugin
Plugin 'flazz/vim-colorschemes'		" Color schemes plugin
Plugin 'scrooloose/nerdtree'		" nerdtree for exploration
Plugin 'zeis/vim-kolor'			" optimal visibility of element within file
Plugin 'majutsushi/tagbar'		"tagbar to browse tags of the current file and 
					" get overview of its struct.
Plugin 'vim-airline/vim-airline'	" Lean & mean status/tabline for vim that's light as air.
Plugin 'vim-airline/vim-airline-themes'	" airline themes
Plugin 'jistr/vim-nerdtree-tabs'	"NERDTree and tabs together in Vim, painlessly
Plugin 'vim-scripts/Conque-GDB'		" embed an interactive shell inside vim, that is used by GDB
Plugin 'scrooloose/syntastic'		" Syntastic is a syntax checking plugin for Vim
Plugin 'brookhong/cscope'

call vundle#end()			" all the plugin should be added before this 
					" line

"call pathogen#infect()			" load other plugins from bundle subfolder
"call pathogen#helptags()		" generate documentation for all plugins in bundle 
					" subfolder

filetype  plugin on			" Enable file type detection. 
					" Use the default filetype 
					" settings.
filetype  indent on 			" Load indent files, to automatically do 
					" language-dependent indenting.
"
syntax  on  				" Switch syntax highlighting on.
"
"
"*******************************
"	 VARIOUS SETTINGS
"*******************************
"
set autoindent                  	" copy indent from current line
set autoread                    	" read open files again when changed outside Vim
set autowrite                   	" write a modified buffer on each :next , ...
set backspace=indent,eol,start  	" backspacing over everything in insert mode
set backup                      	" keep a backup file
set browsedir=current           	" which directory to use for the file browser
set complete+=k                 	" scan the files given with the 'dictionary' option
set encoding=utf-8			" Usually necessary to show unicode glyphs.
set history=50                  	" keep 50 lines of command line history
set hlsearch                    	" highlight the last used search pattern
set incsearch                   	" do incremental searching
set listchars=tab:>.,eol:\$     	" strings to use in 'list' mode
set laststatus=2			" always show the statusline.
"set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
set mouse=a                     	" enable the use of the mouse
set nowrap                      	" do not wrap lines
set number				" enable line numbering
set popt=left:8pc,right:3pc     	" print options
set ruler                       	" show the cursor position all the time
set shiftwidth=4                	" number of spaces to use for each step of indent
set showmatch				" show match in current file
set showcmd                     	" display incomplete commands
set smartindent                 	" smart autoindenting when starting a new line
set tabstop=4                   	" number of spaces that a <Tab> counts for
set t_Co=256				" enable 256 color in vim.
set ttyfast				" the current terminal is a fast terminal (to do 						" more stuff at once)
set updatetime=1000			" Update time of many VIM things.(reasonable value)
set undofile				" save undo's file closes
set undodir=$HOME/.vim/undo		" where to save undo histories
set undolevels=1000			" how many undo is possible
set undoreload=1000			" number of lines to save for undo
set visualbell                 		" visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ 	" wildmenu: ignore these extensions
set wildmenu                    	" command-line completion in an enhanced mode
"
"" GENERAL CONFIGURATION 
let mapleader=','			" change the leader key to colon. Much easier



"
"*******************************
" VARIOUS PLUGIN CONFIGURATIONS
"*******************************
"
"" SOLARIZED
"let g:solarized_termcolors=256 		"16/256
"let g:solarized_termtrans=1
"let g:solarized_degrade=0 		"For test purpose only
"let g:solarized_bold=1
"let g:solarized_underline=0
"let g:solarized_italic=1
"let g:solarized_contrast="high" 	"low/normal/high
"let g:solarized_visibility="high" 	"low/normal/high
"call togglebg#map("<F9>")
"
"" PLUGIN Kolor
"let g:kolor_italic=1                    " Enable italic. Default: 1
"let g:kolor_bold=1                      " Enable bold. Default: 1
"let g:kolor_underlined=0                " Enable underline. Default: 0
"let g:kolor_alternative_matchparen=0    " Gray 'MatchParen' color. Default: 0

"" NERDTREE
map <leader>n :NERDTreeTabsToggle<CR>	" change leader key stroke
"let g:NERDTreeDirArrowExpandable = "▸"
"let g:NERDTreeDirArrowCollapsible = "▾"	

""TAGBAR
map <leader>tb :TagbarToggle<CR>	" tagbar toggling shortcut
"
"" PLUGIN VIM-AIRLINE
let g:airline#extensions#tabline#enable = 1	" Enable smarter tab line
"let g:airline#extensions#tabline#left_alt_sep = '>' " tab line separator
"let g:airline_powerline_fonts = 1	" please install powerline-fonts before using
					" this line.
let g:airline_left_sep = '▶'		" the separator used on the left side >
let g:airline_right_sep = '◀'		" the separator used on the right side <
	

"" YOUCOMPLETEME
let g:ycm_server_python_interpreter = '/usr/bin/python'

"" SYNTASTIC 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:airline_section_c = airline#section#create('%t')
	
"" CONQUEGDB
let g:ConqueGdb_Leader = '/'

"" COLOR SCHEME
syntax enable
set background=dark			" quite a bit easier to read under direct sunlight.
colorscheme solarized		   	" this is my favorite one ;-)




