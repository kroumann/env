"
"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
"if has("autocmd")
  "autocmd BufEnter * :lchdir %:p:h
"endif
"
"-------------------------------------------------------------------------------
" Triger autoreload and notify on file change on disk
"-------------------------------------------------------------------------------
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"------------------------------------------------------------------------------
" Tmux automatic windows rename with current editing file.
" This should be completed with some extra in tmux config file
" --------------------------------------------------------------------------
" let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
" if &term == "screen"
"  set t_ts=k
"  set t_fs=\
" endif
" if &term == "screen" || &term == "xterm"
"  set title
"  set titleold=
" endif

 if has("autocmd")
	 autocmd BufReadPost,FileReadPost,BufNewFile,TabEnter *
				 \ call system("tmux rename-window 'vim(" . expand("%:t") .")'")
	autocmd VimLeave *
				\ call system("tmux rename-window 'bash'")
"				\ call system("tmux rename-window '" . expand("%:p:h:t") ."'")
"	autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
"	set title
 endif
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
"
"
" -------------auto-commands ------------------------
if has ('autocmd')				"Remain compatible with earlier version
 augroup vimrc
	autocmd! BufWritePost $MYVIMRC source % | echom "reloaded " . $MYVIMRC | redraw	" automatic source the vimrc on save.
 augroup END
 endif 				"has autocmd

" ----------------------------------Python---------------------------------------
augroup python
	autocmd!
	autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
augroup END


" show trailing whitespaces with a red bar
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()


" open-browser vim"
let g:openbrowser_search_engines = extend(
			\ get(g:,  'openbrowser_search_engines',  {}),
			\ {
			\   'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
			\ },
			\ 'keep'
			\)


" ---------------------------tpop vim-obsession-------------------------------
"augroup sourcesession
	"autocmd!
	"autocmd VimEnter * nested
				"\ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
				"\   source Session.vim |
				"\ endif
"augroup END

"augroup ObsessionGroup
	"autocmd!
	" When opening a file,  make sure we record the Vim session with its
	" tabs and splits.
	" Checking 'modified' avoids recording a session when reading from stdin.
	" From https://github.com/tpope/vim-obsession/issues/17
	" Calling Obsession when the session is being recorded would pause the recording,
	" that's why we check if v:this_session is empty.
	"autocmd VimEnter * nested
				"\ if !&modified && empty(v:this_session) |
				"\   Obsession |
				"\   echo "Recording new session" |
				"\ endif
"augroup END
