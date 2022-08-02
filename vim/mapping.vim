"===================================================================================
"  FILE:  		 mapping.vim
"  DESCRIPTION:  this file contains my personal vim mapping
"  		 inspired from Fritz Mehner suggestion
"  AUTHOR:  	 M. KOUROUMA
"  CREATED:  	04.02.2022
"===================================================================================
"
"
"------------------------- PLUGIN: FZF ----------------------------------------"
"
" fzf in project directory not in the current as default
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
nnoremap <silent> <C-p> :ProjectFiles<CR>

"------------------------ guttentag and guttentag plus ------------------------"
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" You can disable the default keymaps by:
let g:gutentags_plus_nomap = 1

"---------------------------- vim-which-key -----------------------------------"
" Register which key map
call which_key#register(',',  "g:which_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey ','<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual  ','<CR>

" Define prefix dictionary
let g:which_key_map =  {}
let g:which_key_sep = ': '
" Set a shorter timeout,  default is 1000
set timeoutlen=100

let g:which_key_use_floating_win = 1

" Single mappings
"let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'        , 'comment' ]
"let g:which_key_map['f'] = [ ':Files'                           ,  'search files' ]
"let g:which_key_map['h'] = [ '<C-W>s'                           ,  'split below']
"let g:which_key_map['S'] = [ ':Startify'                        ,  'start screen' ]
"let g:which_key_map['T'] = [ ':Rg'                              ,  'search text' ]
"let g:which_key_map['E'] = [ ':SSave'                           ,  'save session']
"let g:which_key_map['L'] = [ ':SLoad'                           ,  'load session']
"let g:which_key_map['l'] = [ ':Limelight!!'                     ,  'limelight']
"let g:which_key_map['z'] = [ ':Goyo'                            ,  'zen mode']
"let g:which_key_map['r'] = [ ':RnvimrToggle'                    ,  'ranger' ]
"let g:which_key_map['g'] = [ ':FloatermNew lazygit'             ,  'git']
"let g:which_key_map['d'] = [ ':FloatermNew lazydocker'          ,  'docker']
"let g:which_key_map['k'] = [ ':FloatermNew k9s'                 ,  'k9s']
"let g:which_key_map['t'] = [ ':FloatermNew'                     ,  'terminal']
"let g:which_key_map['v'] = [ '<C-W>v'                           ,  'split right']
"
" s is for search
let g:which_key_map.s = {
			\ 'name' : '+search' ,
			\ '/' : [':History/'                 ,  'history'],
			\ ';' : [':Commands'                 ,  'commands'],
			\ 'a' : [':Ag'                       ,  'text Ag'],
			\ 'b' : [':BLines'                   ,  'current buffer'],
			\ 'B' : [':Buffers'                  ,  'open buffers'],
			\ 'c' : [':Commits'                  ,  'commits'],
			\ 'C' : [':BCommits'                 ,  'buffer commits'],
			\ 'f' : [':Files'                    ,  'files'],
			\ 'g' : [':GFiles'                   ,  'git files'],
			\ 'G' : [':GFiles?'                  ,  'modified git files'],
			\ 'h' : [':History'                  ,  'file history'],
			\ 'H' : [':History:'                 ,  'command history'],
			\ 'l' : [':Lines'                    ,  'lines'] ,
			\ 'm' : [':Marks'                    ,  'marks'] ,
			\ 'M' : [':Maps'                     ,  'normal maps'] ,
			\ 'p' : [':Helptags'                 ,  'help tags'] ,
			\ 'P' : [':Tags'                     ,  'project tags'],
			\ 's' : [':Snippets'         		 ,  'snippets'],
			\ 'S' : [':Colors'                   ,  'color schemes'],
			\ 't' : [':Rg'                       ,  'Rg text'],
			\ 'T' : [':BTags'                    ,  'buffer tags'],
			\ 'w' : [':Windows'                  ,  'search windows'],
			\ 'y' : [':Filetypes'                ,  'file types'],
			\ 'z' : [':FZF'                      ,  'FZF'],
			\ }

" x is for vim-plug
let g:which_key_map.x = {
			\ 'name' : '+plug' ,
			\ 'i' : [':PlugInstall'              ,  'install'],
			\ 'u' : [':PlugUpdate'               ,  'update'],
			\ 'c' : [':PlugClean'                ,  'clean'],
			\ 's' : [':PlugStatus'				 ,  'status'],
			\ }

" w is for windows
let g:which_key_map.w = {
			\ 'name' : '+windows' ,
			\ 'w' : ['<C-W>w'     , 'other-window']          ,
			\ 'd' : ['<C-W>c'     , 'delete-window']         ,
			\ '-' : ['<C-W>s'     , 'split-window-below']    ,
			\ '|' : ['<C-W>v'     , 'split-window-right']    ,
			\ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
			\ 'h' : ['<C-W>h'     , 'window-left']           ,
			\ 'j' : ['<C-W>j'     , 'window-below']          ,
			\ 'l' : ['<C-W>l'     , 'window-right']          ,
			\ 'k' : ['<C-W>k'     , 'window-up']             ,
			\ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
			\ 'J' : [':resize +5'  , 'expand-window-below']  ,
			\ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
			\ 'K' : [':resize -5'  , 'expand-window-up']     ,
			\ '=' : ['<C-W>='     , 'balance-window']        ,
			\ 's' : ['<C-W>s'     , 'split-window-below']    ,
			\ 'v' : ['<C-W>v'     , 'split-window-below']    ,
			\ 'r'  : ['<C-W>r'	  , 'rotate-windows']		 ,
			\ '?' : ['Windows'    , 'fzf-window']            ,
			\ }

" b for buffer
let g:which_key_map.b = {
			\ 'name' : '+buffer' ,
			\ '1' : ['b1'        , 'buffer 1']        ,
			\ '2' : ['b2'        , 'buffer 2']        ,
			\ 'd' : ['bd'        , 'delete-buffer']   ,
			\ 'f' : ['bfirst'    , 'first-buffer']    ,
			\ 'h' : ['Startify'  , 'home-buffer']     ,
			\ 'l' : ['blast'     , 'last-buffer']     ,
			\ 'n' : ['bnext'     , 'next-buffer']     ,
			\ 'p' : ['bprevious' , 'previous-buffer'] ,
			\ '?' : ['Buffers'   , 'fzf-buffer']      ,
			\ }

" l for lsp
let g:which_key_map.l = {
			\ 'name' : '+lsp',
			\ 'f' : ['spacevim#lang#util#Format()'          , 'formatting']       ,
			\ 'r' : ['spacevim#lang#util#FindReferences()'  , 'references']       ,
			\ 'R' : ['spacevim#lang#util#Rename()'          , 'rename']           ,
			\ 's' : ['spacevim#lang#util#DocumentSymbol()'  , 'document-symbol']  ,
			\ 'S' : ['spacevim#lang#util#WorkspaceSymbol()' , 'workspace-symbol'] ,
			\ 'g' : {
			\ 'name': '+goto',
			\ 'd' : ['spacevim#lang#util#Definition()'     , 'definition']      ,
			\ 't' : ['spacevim#lang#util#TypeDefinition()' , 'type-definition'] ,
			\ 'i' : ['spacevim#lang#util#Implementation()' , 'implementation']  ,
			\ },
			\ }

" g is for gutentags-plus
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

let g:which_key_map.g = {
			\ 'name'  : '+tags',
			\ 's' : 'symbol references',
			\ 'g' : 'symbol definition',
			\ 'c' : 'functions called',
			\ 't' : 'caller functions',
			\ 'e' : 'egrep pattern',
			\ 'f' : 'file name',
			\ 'i' : 'files including',
			\ 'd' : 'symbol assigned',
			\ 'a' : 'symbol places',
			\ 'z' : 'ctags database',
			\ }

" NERDTREE
let g:NERDTreeDirArrowExpandable = "▸"
let g:NERDTreeDirArrowCollapsible = "▾"

" n for NERDTREE
let g:which_key_map.n = {
			\ 'name': '+nerdtree',
			\ 'f' : [':NERDTreeFind'   , 'Move to file in Nerdtree'] ,
			\ 't' : [':NERDTreeToggle' , 'Toggle Windows On/Off']    ,
			\ 'n' : [':NERDTree'	   , 'Move cursor to Nerdtree']  ,
			\ }

" file actions
let g:which_key_map.f = {'name' : '+file'}

" Copy/Paste between session (primary register replacement):
vmap <leader>y :w! /tmp/mvitmp<CR>
nmap <leader>p :r! cat /tmp/mvitmp<CR>
"
let g:which_key_map.y = 'copy (cross-session)'
let g:which_key_map.p = 'paste (cross-session)'
"
" ------------- editing config files ---------------
nnoremap <silent> <leader>fev :tabedit $MYVIMRC<cr>
nnoremap <silent> <leader>fet :tabedit ~/.tmux.conf<cr>
let g:which_key_map.f.e = {
			\ 'name' : '+edit',
			\ 'v'	: 'open-vimrc',
			\ 't'	: 'open-tmux.conf',
			\}

nnoremap <silent> <leader>frv :so $MYVIMRC<cr>
let g:which_key_map.f.r = {
			\ 'name' : '+reload',
			\ 'v'	: 'reload vimrc',
			\}

"nnoremap <silent> <leader>et :tabedit ~/.tmux.conf<cr> 	" edit my tmux config file

" Copy/Paste from CLIPBARD register:
"noremap <Leader>Y "+y
"noremap <Leader>P "+p
"
"
"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q (KDE): Write all changed buffers and exit Vim
"-------------------------------------------------------------------------------
"nnoremap  <C-q>    :wqall<CR>
"

"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q : Write all changed buffers and exit Vim
"-------------------------------------------------------------------------------
nmap  <C-q>    :waq<CR>
nmap  <C-Q>    :waq<CR>
"
"-------------------------------------------------------------------------------
" comma always followed by a space
"-------------------------------------------------------------------------------
inoremap  ,  ,<Space>
"
"-------------------------------------------------------------------------------
"  some additional hot keys
"-------------------------------------------------------------------------------
"    F2   -  write file without confirmation
"    F3   -  NERDCommenter toggle comment ON/OFF
"    F4   -  show tag under curser in the preview window (tagfile must exist!)
"    F5   -  open quickfix error window
"    F6   -  close quickfix error window
"    F7   -  display previous error
"    F8   -  display next error
"    F9   -  enable spell check
"-------------------------------------------------------------------------------
"
map   <silent> <F2>        :write<CR>
map   <silent> <F3>        :call nerdcommenter#Comment('n', 'Toggle')<CR>j
nmap  <silent> <F4>        :exe ":ptag ".expand("<cword>")<CR>
map   <silent> <F5>        :copen<CR>
map   <silent> <F6>        :cclose<CR>
map   <silent> <F7>        :cp<CR>
map   <silent> <F8>        :cn<CR>
map   <silent> <F9>        :set spell! spelllang=en_us<CR>


imap  <silent> <F2>   <Esc>:write<CR>
imap  <silent> <F3>   <Esc>:call nerdcommenter#Comment('n', 'Toggle')<CR>j
imap  <silent> <F4>   <Esc>:exe ":ptag ".expand("<cword>")<CR>
imap  <silent> <F5>   <Esc>:copen<CR>
imap  <silent> <F6>   <Esc>:cclose<CR>
imap  <silent> <F7>   <Esc>:cp<CR>
imap  <silent> <F8>   <Esc>:cn<CR>
imap  <silent> <F9>   <Esc>:set spell! spelllang=en_us<CR>
"
"-------------------------------------------------------------------------------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
"
nnoremap  <silent> <tab>  <Esc>:if &modifiable && !&readonly &&
     \                  &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly &&
     \                  &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------

" Jump to opening closing parenthesis, square bracket or brace
"-------------------------------------------------------------------------------
nnoremap % v%
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
"
vnoremap ( s()<Esc>P<Right>%
vnoremap [ s[]<Esc>P<Right>%
vnoremap { s{}<Esc>P<Right>%
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and select mode)
"-------------------------------------------------------------------------------
xnoremap  '  s''<Esc>P<Right>
xnoremap  "  s""<Esc>P<Right>
xnoremap  `  s``<Esc>P<Right>
"

"--------------------------- vim-lsp / ultisnip / snippet  ----------------------"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<C-n>"
let g:UltiSnipsJumpBackwardTrigger = "<C-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"if executable('clangd')
	"augroup vim_lsp_cpp
		"autocmd!
		"autocmd User lsp_setup call lsp#register_server({
					"\ 'name': 'clangd', 
					"\ 'cmd': {server_info->['clangd']}, 
					"\ 'whitelist': ['c',  'cpp',  'objc',  'objcpp',  'cc'], 
					"\ })
		"autocmd FileType c, cpp, objc, objcpp, cc setlocal omnifunc=lsp#complete
	"augroup end
"endif

"set completeopt+=menuone


" disable coc plugin warning for vim version
let g:coc_disable_startup_warning = 1

" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'


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
"" C-SUPPORT
"let g:C_MapLeader = ','
"
"" PLUGIN Kolor
"let g:kolor_italic=1                    " Enable italic. Default: 1
"let g:kolor_bold=1                      " Enable bold. Default: 1
"let g:kolor_underlined=0                " Enable underline. Default: 0
"let g:kolor_alternative_matchparen=0    " Gray 'MatchParen' color. Default: 0

" If another buffer tries to replace NERDTree,  put it in the other window, and bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    "\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

""TAGBAR
"map <leader>tb :TagbarToggle<CR>	" tagbar toggling shortcut
"
"" PLUGIN VIM-AIRLINE
"let g:airline#extensions#tabline#enable = 1	" Enable smarter tab line
"let g:airline#extensions#tabline#left_alt_sep = '>' " tab line separator
"let g:airline_powerline_fonts = 1	" please install powerline-fonts before using
					" this line.
"let g:airline_left_sep = '▶'		" the separator used on the left side >
"let g:airline_right_sep = '◀'		" the separator used on the right side <

"" CTAGS + CSCOPE
" let &tags=$CTAGS_DB
"
"" YOUCOMPLETEME
" let g:ycm_server_python_interpreter = '/usr/bin/python3'

"" SYNTASTIC
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:airline_section_c = airline#section#create('%t')

"" CONQUEGDB
"let g:ConqueGdb_Leader = '/'

"" VIM LSP (Language server protocol) cquery
"autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fv :LspCqueryDerived<CR>
"autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fc :LspCqueryCallers<CR>
"autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fb :LspCqueryBase<CR>
"autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fi :LspCqueryVars<CR>

" navigate in tabs with arrows 
"noremap <leader>h gT
"noremap <leader>l gt
"nnoremap <C-Left> :tabprevious<CR>
"nnoremap <C-Right> :tabnext<CR>


"" COLOR SCHEME
"syntax enable
"set background=dark			" quite a bit easier to read under direct sunlight.
"colorscheme solarized		   	" this is my favorite one ;-)


