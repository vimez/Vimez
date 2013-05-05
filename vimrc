" vim:ft=vim:fdm=marker:
"         _
"  __   _(_)_ __ ___  _ __ ___
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__
"    \_/ |_|_| |_| |_|_|  \___|
"
" Authors:       Fontaine Cook, Various Contributors
" Description:   The primary Vim configuration file.
"-------------------------------------------------------------------------------

" BOOTSTRAP:"{{{
" ******************************************************************************
" "## Pre Initilization:"{{{
set nocompatible
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:vundle_default_git_proto = 'git'
Bundle "gmarik/vundle"
"-------------------------------------------------------------------------------

"}}}
" "## Frontend Bundles:"{{{
Bundle "vimez/vim-themes"
Bundle "vim-scripts/CSApprox"
Bundle "vim-scripts/ScrollColors"
Bundle "lilydjwg/colorizer"
Bundle "othree/html5.vim"
Bundle "hail2u/vim-css-syntax"
Bundle "hail2u/vim-css3-syntax"
Bundle "groenewege/vim-less"
Bundle "pangloss/vim-javascript"
Bundle "tpope/vim-markdown"
Bundle "tpope/vim-haml"
Bundle "nelstrom/vim-markdown-folding"
"-------------------------------------------------------------------------------

"}}}
" "## Backend Bundles:"{{{
Bundle "Shougo/neocomplcache"
Bundle "Shougo/neosnippet"
Bundle "Lokaltog/vim-powerline"
Bundle "vimez/vim-tmux"
Bundle "vimez/vim-yankring"
Bundle "vim-scripts/SyntaxAttr.vim"
Bundle "tpope/vim-surround"
Bundle "tomtom/tcomment_vim"
Bundle "sjl/gundo.vim"
Bundle "docunext/closetag.vim"
Bundle "tpope/vim-repeat"
Bundle "kien/ctrlp.vim"
Bundle "benmills/vimux"
Bundle "duff/vim-bufonly"
Bundle "xolox/vim-session"
Bundle "scrooloose/nerdtree"
Bundle "vim-scripts/Rename2"
Bundle "godlygeek/tabular"
Bundle "jiangmiao/auto-pairs"
Bundle "endel/ctrlp-filetype.vim"
Bundle "tpope/vim-git"
Bundle "vimez/vim-showmarks"
Bundle "tristen/vim-sparkup"
Bundle "tpope/vim-fugitive"
Bundle "gregsexton/gitv"
Bundle "tpope/vim-unimpaired"
Bundle "mattn/webapi-vim"
Bundle "mattn/gist-vim"
"-------------------------------------------------------------------------------

"}}}
" "## Post Initialization:"{{{
filetype plugin indent on
"-------------------------------------------------------------------------------

"}}}
"-------------------------------------------------------------------------------

"}}}
" GENERAL:"{{{
" ******************************************************************************

" "## Commandline""{{{
" More convenient entrance to Commandline and Commandline Edit mode from Normal mode.
nnoremap ; :
vnoremap ; :
nnoremap ;; ;
nnoremap q; q:
"-------------------------------------------------------------------------------

"}}}
" "## Native Scripts""{{{
"set runtimepath=$VIMRUNTIME,~/.vim.local/
runtime macros/matchit.vim
runtime ftplugin/man.vim
"-------------------------------------------------------------------------------

"}}}
" "## Time Settings""{{{
set timeoutlen=500
set updatetime=1000
"-------------------------------------------------------------------------------

"}}}
" "## Leader Keys""{{{
let mapleader="\<Space>" " Global mod key.
let maplocalleader="\\"  " Local mod key primarily for filetype specific maps.
"-------------------------------------------------------------------------------

"}}}
" "## Encoding""{{{
" Default to UTF-8 character encoding unless the terminal doesn't support it. In
" which case use Latin1 character encoding instead.
if has("multi_byte")
	set encoding=utf-8
	scriptencoding utf-8
	if $TERM == "linux" || $TERM_PROGRAM == "GLterm"
		set termencoding=latin1
	endif
	if $TERM == "xterm" || $TERM == "xterm-color" || $TERM == "screen256-color"
		let propv = system
		\ ("xprop -id $WINDOWID -f WM_LOCALE_NAME 8s ' $0' -notype WM_LOCALE_NAME")
		if propv !~ "WM_LOCALE_NAME .*UTF.*8"
			set termencoding=latin1
		endif
	endif
endif
"-------------------------------------------------------------------------------

"}}}
" "## Color Scheme""{{{
set t_Co=256                " Force terminal to go into 256 color mode.
set synmaxcol=300           " Prevent long lines from slowing down redraws.
syntax on                   " Syntax highlighting on.
colorscheme default         " Default color scheme.

" Show syntax highlighting group for current word.
nnoremap <Leader>syn :call SyntaxAttr()<CR>
"-------------------------------------------------------------------------------

"}}}

"}}}
" FILE:"{{{
" ******************************************************************************

" "## General File Settings""{{{
set fileformats=unix,dos,mac
set hidden         " Hide buffers when they are abandoned
set confirm        " Provide user friendly prompt over nasty error messages.
set autoread       " Automatically re-read a file if modified outside of vim.
set autowrite      " Automatically write a file on certain operations.
set shellslash     " Use forward slash for shell file names (Windows)
set winminwidth=0
set winminheight=0

" Backups.
set backup       " Keep backup file after overwriting a file.
set writebackup  " Make a backup before overwriting a file.
set backupdir=~/.vim.local/tmp/backups//
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif

" Swap files.
set updatecount=100
set directory=~/.vim.local/tmp/swaps//
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

" Views.
set viewdir=~/.vim.local/tmp/view//
set viewoptions=folds,cursor,unix,slash

" Vim Info.
" A memory dump to remember information from the last session. The viminfo file
" is read upon startup and written when exiting Vim.
set viminfo=
set vi+='1000 " Amount of files to save marks
set vi+=f1    " Store global marks A-Z and 0-9
set vi+=<500  " How many registers are saved
set vi+=:500  " Number of lines to save from the command line history
set vi+=@500  " Number of lines to save from the input line history
set vi+=/500  " Number of lines to save from the search history
set vi+=r/tmp " Removable media, for which no marks will be stored
set vi+=!     " Global variables that start with an uppercase letter and
              " don't contain lowercase letters
set vi+=h     " Disable 'hlsearch' highlighting when starting
set vi+=%     " Buffer list (restored when starting Vim without arguments)
set vi+=c     " Convert the text using 'encoding'
set vi+=s100  " Max amount of kilobytes of any single register.
set vi+=n~/.vim.local/tmp/viminfo
"-------------------------------------------------------------------------------

"}}}
" "## Buffer Management""{{{

" "### Create/Find/Open"{{{
" Open files via browser (NERDTree)
let NERDTreeBookmarksFile = expand('~/.vim.local/tmp/NERDTreeBookmarks')
let NERDTreeChDirMode = 2
let NERDTreeMapOpenSplit = 'h'
let NERDTreeMapPreviewSplit = 'gh'
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeMapPreviewVSplit = 'gv'
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen  =  1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeWinPos = "left"
nnoremap <silent><Leader>bb :nohlsearch<CR>\|:NERDTreeFind<CR>

" Open files via search (CtrlP)"
let g:ctrlp_map = '<Leader>ff'
let g:ctrlp_cache_dir = '~/.vim.local/tmp/ctrlp/'
let g:ctrlp_open_multiple_files = '1vjr'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_prompt_mappings = {
\ 'PrtExit()':            ['<esc>', ','],
\ 'CreateNewFile()':      ['<c-b>'],
\ }
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }
let g:ctrlp_extensions = ['filetype']

nnoremap <silent><Leader>gg :CtrlPMixed<CR>
nnoremap <silent><Leader>ff :CtrlP<CR>
nnoremap <silent><Leader>jj :CtrlPBuffer<CR>
nnoremap <silent><Leader>kk :CtrlPMRU<CR>
nnoremap <silent><Leader>ll :CtrlPFiletype<CR>

" Open files via paths in buffers.
nnoremap gfh :wincmd f<CR>
nnoremap gfv :vertical wincmd f<CR>
"-------------------------------------------------------------------------------

"}}}
" "### Write/Close/Quit""{{{
" Write the current buffer.
nnoremap <silent><Leader>w :write<CR>

" Write a copy of the current buffer as...  and continue editing original buffer.
nnoremap <Leader>wcb :write <C-R>=expand("%:p:h") . "/" <CR>

" Edit new copy of the current buffer.
nnoremap <Leader>ecb :saveas <C-R>=expand("%:p:h") . "/" <CR>

" Write the current buffer and quit the window.
nnoremap <silent><Leader>wq :wq<CR>

" Write and quit all buffers and windows; exiting Vim.
nnoremap <silent><Leader>wqa :SaveSession<CR>:wqa<CR>
nnoremap <silent><Leader>Q   :SaveSession<CR>:wqa<CR>

" Write all buffers.
nnoremap <silent><Leader>wa :wall<CR>:echo 'All buffers written'<CR>

" Write current buffer as root.
cmap w!! w !sudo tee % >/dev/null

" Rename current buffer (Rename2).
nnoremap <Leader>rb :Rename<Space>

" Close the current buffer.
nnoremap <silent><Leader>cb :<C-u>Kwbd<CR>

" Delete the current buffer.
nnoremap <silent><Leader>db :<C-u>bw<CR>

" Delete the current buffer and file.
nnoremap <Leader>DDF :call DeleteFile()<CR>

" Close the current buffer and quit the window.
nnoremap <silent><Leader>cbb :bdelete<CR>

" Close all buffers.
nnoremap <silent><Leader>cab :exec "1," . bufnr('$') . "bd"<CR>
\ :echo 'All buffers closed'<CR>

" Close all inactive buffers.
nnoremap <silent><Leader>cib :silent! call CloseInactiveBuffers()<CR>
\ :echo 'All inactive buffers closed'<CR>

" Close all unlisted buffers.
nnoremap <silent><Leader>cub :silent! call CloseUnlistedBuffers()<CR>
\ :echo 'All unlisted buffers closed'<CR>

" Quit a window without writting the current buffer.
nnoremap <silent><Leader>qq :q<CR>
vnoremap <silent><Leader>qq <Esc>:q<CR>

" Quit all windows without writting any buffers.
nnoremap <silent><Leader>qa  :SaveSession<CR>:qa<CR>
vnoremap <silent><Leader>qa  :SaveSession<CR>:qa<CR>

" Close other buffers (BufOnly)
nnoremap <silent><Leader>cob :BufOnly<CR>
"-------------------------------------------------------------------------------

"}}}
" "### Buffer Navigation""{{{
" List all buffers.
nnoremap <Leader>ls :ls!<CR>

" Flip through buffer list.
nnoremap <silent>gh :bprev<CR>
nnoremap <silent>gl :bnext<CR>
"-------------------------------------------------------------------------------

"}}}
"}}}
" "## Window Management""{{{
" Focus.
nnoremap <silent><C-h> <C-w>h
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l

" Move.
noremap <silent><C-m><C-h> <C-w>H
noremap <silent><C-m><C-j> <C-w>J
noremap <silent><C-m><C-k> <C-w>K
noremap <silent><C-m><C-l> <C-w>L
noremap <silent><C-m><C-x> <C-w>x

" Close.
noremap <silent><C-c><C-j> :wincmd j<CR>:close<CR>
noremap <silent><C-c><C-h> :wincmd h<CR>:close<CR>
noremap <silent><C-c><C-k> :wincmd k<CR>:close<CR>
noremap <silent><C-c><C-l> :wincmd l<CR>:close<CR>
noremap <silent><C-c><C-w> :close<CR>
noremap <silent><C-c><C-o><C-w> :only<CR>

" Split.
nnoremap <silent><C-s><C-v> :vsplit\|bnext<CR>
nnoremap <silent><C-s><C-h> :split\|bnext<CR>
set splitright
set splitbelow

" Resize.
nnoremap <Left>  <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up>    <C-w>+
nnoremap <Up>    <C-w>+
nnoremap <Down>  <C-w>-

" Maximize and restore window.
let g:windowmaximized = 0
map <silent><F11> :call MaxRestoreWindow()<CR>
"-------------------------------------------------------------------------------

"}}}
" "## Tab Management""{{{
nnoremap <silent><leader><Right> :tabprevious<CR>
nnoremap <silent><leader><Left> :tabnext<CR>
nnoremap <silent><Leader>nt :tabnew<CR>
nnoremap <silent><Leader>ct :tabclose<CR>
"-------------------------------------------------------------------------------

"}}}
" "## Session Management""{{{
" Changes the effect of the :mksession command. It is a comma separated list of
" words.  Each word enables saving and restoring something:
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_directory = '~/.vim.local/tmp/sessions/'

set sessionoptions=
set ssop+=blank        " Blank	empty windows
set ssop+=buffers	     " Hidden and unloaded buffers, not just those in windows
set ssop+=curdir	     " The current directory
set ssop+=folds	       " Manually created folds, opened/closed folds and local
                       " fold options
set ssop-=globals	     " Global variables that start with an uppercase letter
                       " and contain at least one lowercase letter.  Only
                       " String and Number types are stored.
set ssop+=help		     " Restore help windows.
set ssop+=localoptions " Options and mappings local to a window or buffer (not
                       " global values for local options)
set ssop+=options	     " All options and mappings (also global values for local
                       " options)
set ssop+=resize	     " Size of the Vim window: 'lines' and 'columns'
set ssop-=sesdir	     " The directory in which the session file is located
                       " will become the current directory (useful with
                       " projects accessed over a network from different
                       " systems)
set ssop+=slash	       " Backslashes in file names replaced with forward
                       " slashes
set ssop+=tabpages	   " All tab pages; without this only the current tab page
                       " is restored, so that you can make a session for each
                       " tab page separately
set ssop+=unix		     " With Unix end-of-line format (single <NL>), even when
                       " on Windows or DOS
set ssop+=winpos	     " Position of the whole Vim window
set ssop+=winsize	     " Window sizes

nnoremap <silent><Leader>ws :SaveSession<CR>
nnoremap <silent><Leader>ns :call NewSession()<CR>
nnoremap <silent><Leader>os :SaveSession<CR><Bar>:OpenSession<CR>
nnoremap <silent><Leader>cs :SaveSession<CR><Bar>:CloseSession<CR>
nnoremap <silent><Leader>ds :DeleteSession<CR>
nnoremap <silent><Leader>vs :ViewSession<CR>
"-------------------------------------------------------------------------------

"}}}

"}}}
" EDIT:"{{{

" "## Yank/Delete/Put""{{{
" Plugin (Yankring)
set clipboard+=unnamedplus  " Use system clipboard for yanks.
set pastetoggle=<F12>  " Preserve indentation when putting formatted text.
nnoremap <silent><F12> :set invpaste<CR>

function! YRRunAfterMaps()
	nnoremap <silent>Y  :<C-u>YRYankCount 'y$'<CR>
	nnoremap <silent>yh :<C-u>YRYankCount 'y0'<CR>
	nnoremap <silent>yj :<C-u>YRYankCount 'yG'<CR>
	nnoremap <silent>yk :<C-u>YRYankCount 'ygg'<CR>
	nnoremap <silent>yl :<C-u>YRYankCount 'y$'<CR>

	" Preserve the yank post selection/put.
	vnoremap <silent>p :<C-u>YRPaste 'p', 'v'<CR>gv:YRYankRange 'v'<CR>
	" Put and respect surrounding indentation.
	nmap <silent>p :<C-u>YRYankCount ']p'<CR>
	nmap <silent>P :<C-u>YRYankCount ']P'<CR>
	" Leave the cursor at the end of the put.
	nnoremap <silent>gp :<C-u>YRYankCount 'pV`]l'<CR>
	nnoremap <silent>gP :<C-u>YRYankCount 'PV`]l'<CR>
endfunction

" Yank current WORD.
nnoremap <Leader>y yiwe

" Yank current LINE (characterwise).
nnoremap <Leader>yy 0y$$l

" Yank current LINE (linewise).
nnoremap yy yy$l

" Yank current BLOCK.
nnoremap ,y yip}


" Put over current WORD (repeatable).
nnoremap <Leader>p ciw<C-r>0<Esc>

" Put over current LINE (repeatable).
nnoremap <Leader>pp S<C-r>0<Esc>

" Put over current BLOCK (repeatable).
nnoremap ,p :set paste<CR><Bar>cip<C-r>0<Esc><Bar>:set nopaste<CR>

" Open YankRing browser.
nnoremap <silent><Leader>rr :YRShow<CR>

let g:yankring_max_history = 1000
let g:yankring_dot_repeat_yank = 1
let g:yankring_window_height = 7
let g:yankring_min_element_length = 3
let g:yankring_manual_clipboard_check = 1
let g:yankring_history_dir = '~/.vim.local/tmp/'
let g:yankring_history_file = 'yankring_herstory'

" Delete from the cursor to the left.
nnoremap dh v0d
nnoremap dH v0di
nnoremap CC v0r<Space>R

" Delete from the cursor to the right.
nnoremap dl v$hd
nnoremap dL v$hdi
nnoremap DD v0r<Space>

" Delete contents of a line only
nnoremap <silent><Leader>dd cc<Esc>

" Simple delete key in insert mode
inoremap <C-d> <Del>

" Delete contents of several lines only
vnoremap <silent><Leader>dd 0r<Space>

" Delete into a black hole (Cut).
nnoremap ,dd "_dd
"-------------------------------------------------------------------------------

"}}}
" "## Paragraph Formatting""{{{
vnoremap Q gq
nnoremap Q gqip
"-------------------------------------------------------------------------------

"}}}
" "## Undo""{{{
" Plugin (Gundo)
" Persistent undo, along with Gundo to parse the undo history.
set undolevels=1000
set undofile
set undodir=~/.vim.local/tmp/undos//
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
let g:gundo_help=1
let g:gundo_preview_bottom=1
nnoremap <silent><Leader>uu :silent! GundoToggle<CR>
"-------------------------------------------------------------------------------

"}}}
" "## Select All""{{{
nnoremap <C-a> ggVG
nnoremap <Leader>a ggVG
"-------------------------------------------------------------------------------

"}}}
" "## Line/Fold Movement""{{{
" Consistent use of [hjkl] with the Shift modifier to move a line of text
" around. Up/down by one line and left/right by amount of shiftwidth.
nnoremap H <<^
nnoremap L >>^
nnoremap <silent>J :call MoveLineOrFoldDown()<CR>
nnoremap <silent>K :call MoveLineOrFoldUp()<CR>
"-------------------------------------------------------------------------------

"}}}
" "## Block Movement""{{{
" Consistent use of [hjkl] with the Shift modifier to move a block of text
" around. Up/down by one line and left/right by amount of shiftwidth.
vnoremap H <gv^
vmap J ]egv
vmap K [egv
vnoremap L >gv^
"-------------------------------------------------------------------------------

"}}}
" "## Breaks and New Lines""{{{
" Break to line below in NORMAL mode.
nnoremap <CR> i<CR><Esc>

" Break to line above in NORMAL mode.
nnoremap <Leader><CR> DO<Esc>p

" Create a new line below/above in NORMAL mode.
nnoremap  \<CR> o<Esc>
nnoremap \\<CR> O<Esc>

" Create a new line below/above in INSERT mode.
inoremap  \<CR> <Esc>o
inoremap \\<CR> <Esc>O
"-------------------------------------------------------------------------------

"}}}
" "## Join Next/Previous Line""{{{
" Normally Shift-j joins the line below with the current one, but felt it best
" to maintain [hjkl] as directional arrow keys. So, this functionality is mapped
" to Leader jn and jp for join next (line below) and join previous (line above)
" with the current line.
set nojoinspaces
nnoremap <silent><Leader>jn :call Join()<CR>
nnoremap <silent><Leader>jp k<S-v>xpk:call Join()<CR>
"-------------------------------------------------------------------------------

"}}}
" "## Case Manipulation""{{{
" To avoid nasty accidents when attempting to undo while in Visual mode.
vnoremap u <Esc>u
vnoremap gu u
vnoremap gU U
"-------------------------------------------------------------------------------

"}}}
" "## Alignment""{{{
" Plugin (Tabularize)"
if exists(":Tabularize")
	nmap <Leader>a= :Tabularize /=<CR>
	vmap <Leader>a= :Tabularize /=<CR>
	nmap <Leader>a: :Tabularize /:\zs<CR>
	vmap <Leader>a: :Tabularize /:\zs<CR>
endif
"-------------------------------------------------------------------------------

"}}}
" "## Spell Checking""{{{
" Make sure to update the spelllang to your language. Custom words are tucked
" away in the .vim/spell folder.
set spelllang=en_us       " Default language
set spellsuggest=5        " How many spelling suggestions to list
set spellfile=~/.vim.local/dictionaries/en.utf-8.add " Custom spell file
nmap <silent><Leader>ts
			\ :setl spell!<CR><Bar>
			\ :let OnOrOff=&spell<CR><Bar>
			\ :call ToggleOnOff(" Spell Checker", OnOrOff)<CR>
"-------------------------------------------------------------------------------

"}}}

"}}}
" VIEW:"{{{
" ******************************************************************************

" "Title Bar"
" Detected set paste! Disabled neocomplcache.
set title
set titlestring=%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{hostname()}
"-------------------------------------------------------------------------------



" "Cursor Highlights"
" This helps maintain your bearings by highlighting the current line the cursor
" is on as well as the current column.
set cursorline          " Enable cursor line highlight
set nocursorcolumn      " Enable cursor column highlight
let g:cursorcolumnstate=0
nnoremap <silent><Leader>tcc :call ToggleCursorColumn()<CR>
"-------------------------------------------------------------------------------



" "Line Numbers"
set relativenumber
let g:numbertype=1
set numberwidth=4
nnoremap <silent><Leader>tnt :call g:ToggleNumberType()<CR>
nnoremap <silent><Leader>tn :call g:ToggleNumbers()<CR>
"-------------------------------------------------------------------------------



" "Error Alerts"
set noerrorbells        " No audible alerts on error
set novisualbell        " No blinking on error
"-------------------------------------------------------------------------------



" "File Info"
nnoremap <silent><C-g> 2<C-g>
"-------------------------------------------------------------------------------



" "Messages"
set shortmess+=f " Use "(3 of 5)" instead of "(file 3 of 5)"
set shortmess+=i " Use "[noeol]" instead of "[Incomplete last line]"
set shortmess+=l " Use "999L, 888C" instead of "999 lines, 888 characters"
set shortmess+=m " Use "[+]" instead of "[Modified]"
set shortmess+=n " Use "[New]" instead of "[New File]"
set shortmess+=r " Use "[RO]" instead of "[readonly]"
set shortmess-=w " Use "[w]" instead of "written" for file write message
                 " and "[a]" instead of "appended" for ':w >> file' command
set shortmess+=x " Use "[dos]" instead of "[dos format]", "[unix]" instead
                 " of "[unix format]" and "[mac]" instead of "[mac format]".
set shortmess-=a " All of the above abbreviations
set shortmess+=o " Overwrite message for writing a file with subsequent message
                 " for reading a file (useful for ":wn" or when 'autowrite' on)
set shortmess+=O " Message for reading a file overwrites any previous message.
                 " Also for quickfix message (e.g., ":cn").
set shortmess-=s " Don't give "search hit BOTTOM, continuing at TOP" or "search
                 " hit TOP, continuing at BOTTOM" messages
set shortmess+=t " Truncate file message at the start if it is too long to fit
                 " on the command-line, "<" will appear in the left most column.
set shortmess+=T " Truncate other messages in the middle if they are too long to
                 " fit on the command line.  "..." will appear in the middle.
set shortmess-=W " Don't give "written" or "[w]" when writing a file
set shortmess-=A " Don't give the "ATTENTION" message when an existing
                 " swap file is found.
set shortmess+=I " Don't give the intro message when starting Vim |:intro|.
"-------------------------------------------------------------------------------



" "Wildmenu"
set wildchar=<Tab>
set wildcharm=<C-z>
set wildmenu                 " Enable file/command auto-completion
set wildmode=longest,full    " Auto-complete up to ambiguity
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.gif,*.bmp,*.png,*.jpeg   " Binary images
set wildignore+=*.DS_Store,Thumbs.db             " Platform files

cmap <C-h> <Left>
cmap <C-l> <Right>
"-------------------------------------------------------------------------------



" "Non-Printable Characters"
" This controls visibility of non-printable characters that denote certain
" formatting information. Such as eol, tabs, trailing space, etc.
set list
set listchars=eol:\ ,tab:·\ ,trail:\ ,extends:>,precedes:<
nnoremap <silent><Leader>tn
		\ :setlocal list!<CR><Bar>
		\ :let OnOrOff=&list<CR><Bar>
		\ :call ToggleOnOff("Non-Printable Characters", OnOrOff)<CR>
"-------------------------------------------------------------------------------



" "Wraps"
set nowrap              " Turn off wrapping of text
set linebreak           " Wrap at word
set textwidth=80        " Don't wrap lines by default
set whichwrap+=b        " "]" Insert and Replace
set whichwrap+=s        " "[" Insert and Replace
set whichwrap+=h        " "~" Normal
set whichwrap+=l        " <Right> Normal and Visual
set whichwrap+=<        " <Left> Normal and Visual
set whichwrap+=>        " "l" Normal and Visual (not recommended)
set whichwrap+=~        " "h" Normal and Visual (not recommended)
set whichwrap+=[        " <Space> Normal and Visual
set whichwrap+=]        " <BS> Normal and Visual

nnoremap <silent><Leader>tw
		\ :setlocal wrap!<CR><Bar>
		\ :let OnOrOff=&wrap<CR><Bar>
		\ :call ToggleOnOff("Word Wrap", OnOrOff)<CR>
"-------------------------------------------------------------------------------



" "Rule"
nnoremap <silent><Leader>tr :call ToggleRule()<CR>
let g:rulestate = 1
"-------------------------------------------------------------------------------



" "Folds""{{{
set foldenable
set foldcolumn=5
set foldnestmax=5
set foldlevelstart=0
set foldtext=FoldText()
set fillchars=fold:\ ,vert:\ ,diff:·

nnoremap <expr> x ((foldclosed('.')==-1)?('x'):(''))
nnoremap <expr> . ((foldclosed('.')==-1)?('.'):(''))

" Toggle folding on/off.
nnoremap <silent><Leader>tf :call ToggleFolds()<CR>

" Delete a fold.
nnoremap ,df zd

" Delete all folda.
nnoremap ,daf zE

" Close a fold.
nnoremap ,h zc

" Create a fold.
vnoremap ,h zfzc

" Close all folds.
nnoremap ,H zMgg``zz

" Close other folds.
nnoremap ,K zxzz

" Jump to next fold.
nnoremap ,j zjzz
vnoremap ,j zjzz

" Jump to previous fold.
nnoremap ,k zkzz
vnoremap ,k zkzz

" Open a fold.
nnoremap ,l zo

" Create a fold.
vnoremap ,l zfzc

" Open all folds.
nnoremap ,L zR

nnoremap ,f0 :set foldlevel=0<CR>
nnoremap ,f1 :set foldlevel=1<CR>
nnoremap ,f2 :set foldlevel=2<CR>
nnoremap ,f3 :set foldlevel=3<CR>
nnoremap ,f4 :set foldlevel=4<CR>
nnoremap ,f5 :set foldlevel=5<CR>
"-------------------------------------------------------------------------------


"}}}
" "Status Line""{{{
" Plugin (Powerline)
set noshowmode                    " Message on status line to show current mode.
set showcmd                       " Show (partial) command in states line.
set laststatus=2                  " Keep status lines visible at all times.
set cmdheight=2                   " Number of lines to use for the command-line.

let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'default'
let g:Powerline_cache_enabled = 1
let g:Powerline_symbols = 'compatible'
let g:Powerline_stl_path_style = 'filename'
let g:Powerline_mode_n  = 'NORMAL'
let g:Powerline_mode_i  = 'INSERT'
let g:Powerline_mode_R  = 'REPLACE'
let g:Powerline_mode_v  = 'VISUAL'
let g:Powerline_mode_V  = 'VISUAL LINE'
let g:Powerline_mode_cv = 'VISUAL BLOCK'
let g:Powerline_mode_s  = 'SELECT'
let g:Powerline_mode_S  = 'SELECT LINE'
let g:Powerline_mode_cs = 'SELECT BLOCK'
let g:Powerline_symbols_override = {
		\ 'BRANCH': [0x02AE],
		\ 'LINE':'',
		\ }
"-------------------------------------------------------------------------------



"}}}
"}}}
" INSERT:"{{{
" ******************************************************************************

" "## Format Options""{{{
set formatoptions=
set fo-=t  " Auto-wrap text using textwidth
set fo+=c  " Auto-wrap comments using textwidth, inserting the current comment
					 " Leader automatically.
set fo+=r  " Automatically insert the current comment Leader after hitting
					 " <Enter> in Insert mode.
set fo-=o  " Automatically insert the current comment Leader after hitting 'o' or
					 " 'O' in Normal mode.
set fo+=q  " Allow formatting of comments with 'gq'.
					 " Note that formatting will not change blank lines or lines containing
					 " only the comment Leader.  A new paragraph starts after such a line,
					 " or when the comment Leader changes.
set fo-=w  " Trailing white space indicates a paragraph continues in the next line.
					 " A line that ends in a non-white character ends a paragraph.
set fo-=a  " Automatic formatting of paragraphs.  Every time text is inserted or
					 " deleted the paragraph will be reformatted.  See |auto-format|.
					 " When the 'c' flag is present this only happens for recognized
					 " comments.
set fo+=n  " When formatting text, recognize numbered lists.  This actually uses
					 " the 'formatlistpat' option, thus any kind of list can be used.  The
					 " indent of the text after the number is used for the next line.  The
					 " default is to find a number, optionally followed by '.', ':', ')',
					 " ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
					 " well together with "2".
					 " Example: >
					 " 	1. the first item
					 " 	   wraps
					 " 	2. the second item
set fo-=2  " When formatting text, use the indent of the second line of a paragraph
					 " for the rest of the paragraph, instead of the indent of the first
					 " line.  This supports paragraphs in which the first line has a
					 " different indent than the rest.  Note that 'autoindent' must be set
					 " too.  Example: >
					 " 		first line of a paragraph
					 " 	second line of the same paragraph
					 " 	third line.
set fo-=v  " Vi-compatible auto-wrapping in insert mode: Only break a line at a
					 " blank that you have entered during the current insert command.  (Note:
					 " this is not 100% Vi compatible.  Vi has some 'unexpected features' or
					 " bugs in this area.  It uses the screen column instead of the line
					 " column.)
set fo-=b  " Like 'v', but only auto-wrap if you enter a blank at or before
					 " the wrap margin.  If the line was longer than 'textwidth' when you
					 " started the insert, or you do not enter a blank in the insert before
					 " reaching 'textwidth', Vim does not perform auto-wrapping.
set fo-=l  " Long lines are not broken in insert mode: When a line was longer than
					 " 'textwidth' when the insert command started, Vim does not
					 " automatically format it.
set fo-=m  " Also break at a multi-byte character above 255.  This is useful for
					 " Asian text where every character is a word on its own.
set fo-=M  " When joining lines, don't insert a space before or after a multi-byte
					 " character.  Overrules the 'B' flag.
set fo-=B  " When joining lines, don't insert a space between two multi-byte
					 " characters.  Overruled by the 'M' flag.
set fo+=1  " Don't break a line after a one-letter word.  It's broken before it
					 " instead (if possible).
"-------------------------------------------------------------------------------


"}}}
" "## Autocompletion (Omnicompletion/NeoComplCache)""{{{
" Native Autocompletion Settings
set complete+=.		    " Scan the current buffer ('wrapscan' is ignored)
set complete+=w		    " Scan buffers from other windows
set complete+=b		    " Scan other loaded buffers that are in the buffer list
set complete+=u		    " Scan the unloaded buffers that are in the buffer list
set complete+=U		    " Scan the buffers that are not in the buffer list
set complete-=k		    " Scan the files given with the 'dictionary' option
set complete+=kspell  " Use the currently active spell checking |spell|
set complete-=k{dict} " Scan the file {dict}.  Several "k" flags can be given,
											" patterns are valid too.  For example:
											" 	:set complete=k/usr/dict/*,k~/spanish
set complete-=s				" Scan the files given with the 'thesaurus' option
set complete-=s{tsr}	" Scan the file {tsr}.  Several "s" flags can be given,
											" patterns are valid too.
set complete-=i		    " Scan current and included files
set complete-=d				" Scan current and included files for name or macro
											" |i_CTRL-X_CTRL-D|
set complete+=]				" Tag completion
set complete+=t				" Same as "]"

set infercase					" Match is adjusted depending on the typed text.
set pumheight=20			" Pop Up Menu height in lines

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 24
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_temporary_dir = '~/.vim.local/tmp/neocache'

" Enable custom omnicompletion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Toggle auto completion and additional mappings.
nnoremap <Leader>ta :call ToggleAutoComplete()<CR>
inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<BS>"
"-------------------------------------------------------------------------------


"}}}
" "## Snippets (NeoSnippets)""{{{
" let g:neosnippet#disable_runtime_snippets = {'_' : 1,}
let g:neosnippet#snippets_directory = '~/.vim/bundle/, ~/.vim.local/snippets/'

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
nnoremap <Leader>es  :NeoSnippetEdit<CR>

" Set snips_author.
if !exists('snips_author')
	let g:snips_author = 'VimEz'
endif

" imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
" PopupMap <C-y>   neocomplcache#close_popup()
" PopupMap <C-e>   neocomplcache#cancel_popup()
" PopupMap <CR>    neocomplcache#close_popup() . "\<CR>"
" PopupMap <Tab>   "\<C-n>"
" PopupMap <S-Tab> "\<C-p>"
"-------------------------------------------------------------------------------


"}}}
" "## Auto Pairing""{{{
" Plugin (Auto-Pairs)
let g:AutoPairsShortcutFastWrap = '<C-f>'
let g:AutoPairsCenterLine = 0
let g:AutoPairsMapBS = 0
"-------------------------------------------------------------------------------


"}}}
" "## Backspace""{{{
set backspace=indent,eol,start
nnoremap <BS> i<BS><Right><Esc>
"-------------------------------------------------------------------------------


"}}}
" "## Space""{{{
nnoremap ,<Space> i<Space><Esc>l
"-------------------------------------------------------------------------------


"}}}
" "## Tab Indentation (IndentTab)""{{{
set noexpandtab         " Expand tabs using spaces instead of a tab char
set shiftwidth=2        " Amount of shift when in Normal mode
set tabstop=2           " Number of spaces that a <Tab> in the file counts for.
set softtabstop=2       " Set amount of spaces for a tab
set smarttab            " Uses shiftwidth instead of tabstop at start of lines.
set shiftround          " Use multiples of shiftwidth when indenting
set autoindent          " Enable auto indentation
set copyindent          " Copy the previous indentation on autoindenting
set preserveindent      " Preserve existing characters for indenting

	" Give the tab key utiltiy in normal & visual modes.
nnoremap ,<Tab> i<Tab><Esc>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

nnoremap <Leader>st :call TabSize()<CR>

" Toggle soft tab.
nnoremap <silent><Leader>tst
			\ :setlocal expandtab!<CR><Bar>
			\ :let OnOrOff=&expandtab<CR><Bar>
			\ :call ToggleOnOff("Soft Tabs", OnOrOff)<CR>

" Define a Tab command that calls a function that prompts for a tab size and
" applies it uniformally to softtabstop, tabstop, and shiftwidth.
command! -nargs=* Tab call TabSize()
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)
"-------------------------------------------------------------------------------


"}}}
" "## Comments""{{{
nmap gcl <C-_>r
nmap gcb <C-_>b
vmap gcb <C-_>b
nmap gci <C-_>i
nmap gcp <C-_>p
"-------------------------------------------------------------------------------


"}}}

"}}}
" NAVIGATION:"{{{
" ******************************************************************************

" "Escape"
inoremap ,, <Esc>l
inoremap << <Esc>l
cnoremap ,, <C-c>
cnoremap << <C-c>
vnoremap ,, <Esc>
"-------------------------------------------------------------------------------



" "Virtual Edit"
set virtualedit+=block
set virtualedit+=insert
set virtualedit+=onemore
set nostartofline
"-------------------------------------------------------------------------------



" "Cursor Movement"
set scrolloff=5         " Start scrolling x lines before the edge of the window.
set sidescrolloff=5     " Same as above just for columns instead of lines.
nnoremap <Leader>h 0
vnoremap <Leader>h 0
nnoremap <Leader>l $
vnoremap <Leader>l $h

nnoremap <Leader>j ]`
nnoremap <Leader>k [`

" Jumps to prev/next edit points
nnoremap g; g;zz
nnoremap g, g,zz

nnoremap <silent><Leader>m :call cursor(0, virtcol('$')/2)<CR>

nnoremap <C-d> jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
nnoremap <C-u> kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
"-------------------------------------------------------------------------------



" "Marks (Showmarks)"
let g:showmarks_enable=1
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
let g:showmarks_textlower = " "
let g:showmarks_textupper = " "
nnoremap <silent><Leader>dm  :ShowMarksClearMark<CR>
nnoremap <silent><Leader>dam :ShowMarksClearAll<CR>
nnoremap <silent><Leader>tm  :ShowMarksToggle<CR>
" Backtick is more useful than single quote in normal mode.
nnoremap ` '
nnoremap ' `
"------------------------------------------------------------------------------"



" "Insert Mode Navigation"
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"-------------------------------------------------------------------------------



" "Ignore Wrapped Lines"
" Prevent jumping over wrapped lines & use visual lines.
nnoremap j gj
nnoremap k gk
"-------------------------------------------------------------------------------



" "Search"
set hlsearch            " hightlight search terms
set incsearch           " highlight search terms dynamically and incrementally
set ignorecase          " do case insensitive matching
set smartcase           " do smart case matching
set wrapscan            " set the search scan to wrap around the file

nnoremap <silent>,, :nohlsearch<CR>
nnoremap <silent>n nzxzz
nnoremap <silent>N Nzxzz
nnoremap / /\v
vnoremap / /\v

" Bring up last search in a quickfix window.
nnoremap <silent><Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Highlight current word and maintain cursor position.
nnoremap * *<C-o>
nnoremap # #<C-o>

" Highlight current visual selection.
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>
"-------------------------------------------------------------------------------



" "Find and Replace"
vnoremap <C-f> :call FindReplace()<CR>
"-------------------------------------------------------------------------------



"}}}
" TOOLS:"{{{
" ******************************************************************************

" "Help"
nnoremap <silent><F1> viw"zyw:exe "h ".@z.""<CR>
"-------------------------------------------------------------------------------



" "Vim Management"
nmap <silent><Leader>b<Tab> :Bundle<C-z>
nmap <silent><Leader>iv :BundleInstall<CR>
nmap <silent><Leader>uv :BundleInstall!<CR>
nmap <silent><Leader>cv :BundleClean<CR>
nmap <silent><Leader>lv :BundleList<CR>
nmap <silent><Leader>ev :e ~/.vim.local/vimrc.local<CR>
"-------------------------------------------------------------------------------



" "Reload"
nnoremap <silent>,R :call Reload()<CR>
"-------------------------------------------------------------------------------



" "Change Directory"
nmap <Leader>cd :cd %:p:h<cr>
"-------------------------------------------------------------------------------



" "Git Client (Fugitive)"
nnoremap <silent><Leader>gd  :Gdiff<CR>
nnoremap <silent><Leader>gds :!clear<CR>:Git diff --staged<CR>
nnoremap <silent><Leader>gdd :call CloseDiff()<CR>
nnoremap <silent><Leader>gl  :!clear<CR>:Glog<CR>
nnoremap <silent><Leader>gs  :Gstatus<CR>G<C-p>
nnoremap <silent><Leader>gw  :Gwrite<CR>
nnoremap <silent><Leader>ge  :Gedit :0<CR>
nnoremap <silent><Leader>gb  :Gblame<CR>
nnoremap <silent><Leader>gco :Gcheckout<CR>
nnoremap <silent><Leader>gcm :Gcommit<CR>
nnoremap <silent><Leader>gm  :Gmove<CR>
nnoremap <silent><Leader>gr  :Gremove<CR>
nnoremap <silent><Leader>gv  :Gitv<CR>
nnoremap <silent><Leader>gp  :silent! !clear<CR>:Git push<CR>:redraw!<CR>
"-------------------------------------------------------------------------------



" "Execute Terminal Commands (Vimux)"
let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"

" Prompt for a command to run
nnoremap <Leader>xp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
nnoremap <Leader>xl :VimuxRunLastCommand<CR>

" Inspect runner pane
nnoremap <Leader>xi :VimuxInspectRunner<CR>

" Interrupt any command running in the runner pane
nnoremap <Leader>xs :VimuxInterruptRunner<CR>

" Clear ths tmux history of the runner pane for when
" you enter tmux scroll mode inside the runner pane.
nnoremap <Leader>xx :VimuxClearRunnerHistory<CR>

" Close vim tmux runner opened by VimuxRunCommand
nnoremap <Leader>xq :VimuxCloseRunner<CR>

" Close all other tmux panes in current window
nnoremap <Leader>xa :VimuxClosePanes<CR>

nnoremap <Leader>xc :call VimuxRunCommand("clear")<CR>

nnoremap <F9> :call VimuxRunCommand("colors")<CR>
"-------------------------------------------------------------------------------



" "Present Working Directory"
nnoremap <silent><Leader>pwd :pwd<CR>
"-------------------------------------------------------------------------------



" "Color Highlights (Colorizer)"
let g:ColorizerState = 0
let g:colorizer_nomap = 1
let g:colorizer_fgcontrast = 1
nmap <silent><Leader>tch :call ToggleColorHighlights()<CR>
"-------------------------------------------------------------------------------



" "Highlight Words of Interest"
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" Highlight Colors
hi def InterestingWord1 guifg=#000000 guibg=#ffa724
hi def InterestingWord2 guifg=#000000 guibg=#aeee00
hi def InterestingWord3 guifg=#000000 guibg=#8cffba
hi def InterestingWord4 guifg=#000000 guibg=#b88853
hi def InterestingWord5 guifg=#000000 guibg=#ff9eb8
hi def InterestingWord6 guifg=#000000 guibg=#ff2c4b
"-------------------------------------------------------------------------------



" "}}}
" AUTOMATION:"{{{
" ******************************************************************************
" TODO: Migrate to respective ftplugin/filetype.vim files, once this is fleshed
" out. http://vim.wikia.com/wiki/Keep_your_vimrc_file_clean

" "Vim (Global)"
augroup VimGlobal
	" On Start
	au!
	au VimEnter *  echo "Welcome to VimEz, Happy Coding! :-)"

	" General
	au BufNewFile,BufRead *.vim   setf vim
	au FileType vim               setl omnifunc=syntaxcomplete#Complete
	au BufWritePost *vimrc,*vimrc.local,molokai-ez.vim
			\  nested so $MYVIMRC
			\| nohlsearch
			\| exe 'CSApprox'
			\| call Pl#Load()
			\| call Msg('Vim Configuration Written & Reloaded!')

	au BufNewFile *         silent! 0r  ~/.vim.local/templates/%:e.tpl
	au BufWritePre *        call StripTrailingWhitespace()
	au BufRead *            normal zz
	au VimResized *         wincmd =

	" Improve fold functionality.
	au BufWritePost *       silent! call SaveView()
	au BufRead *            silent! call LoadView()

	" Make cursor highlights follow the cursor.
	au WinEnter *           call WinEnterRoutine()
	au WinLeave *           call WinLeaveRoutine()

	" Improve popup tool environments.
	au WinEnter,BufEnter *  call HelpEnvironment()
	au FileType nerdtree    call NERDTreeEnvironment()
	au FileType vundle      call VundleEnvironment()
	au FileType gundo       call GundoEnvironment()
	au FileType qf          call QuickFixEnvironment()
augroup END
"-----------------------------------------------------------------------------



" "Apache Config"
augroup ApacheConfig
	au!
	au BufNewFile,BufRead /*apache*  setf apache
augroup END
"-----------------------------------------------------------------------------



" "C"
augroup C
	au!
	au FileType c  setl omnifunc=ccomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "CSS/SCSS"
augroup CSS
	au!
	au FileType css,scss  setl omnifunc=csscomplete#CompleteCSS
	au FileType css,scss  let g:cssfoldstate = 0

	au FileType css,scss  nmap <silent><buffer>
		\	<LocalLeader>tf :call ToggleCSSFold()<CR>

	au FileType scss      nmap <silent><buffer>
		\ <LocalLeader>= :silent! w<CR>\|:!sass-convert -i --indent t %<CR>\|:e<CR>

	au FileType css,scss  setl equalprg=csstidy\ -
		\\ --silent=true
		\\ --template=$HOME/.vim.local/templates/csstidy.tpl
		\\ --preserve_css=true
		\\ --merge_selectors=0
		\\ --sort_properties=true
		\\ --compress_font-weight=false
		\\ --compress_colors=false
		\\ --sort_selectors=false
augroup END
"-----------------------------------------------------------------------------



" "Drupal CMS Framework"
augroup DrupalCMS
	au!
	au BufNewFile,BufRead *.module   setf php
	au BufNewFile,BufRead *.install  setf php
	au BufNewFile,BufRead *.test     setf php
augroup END
"-----------------------------------------------------------------------------



" "Git"
augroup Git
	au!
	au Filetype git,gitcommit call GitEnvironment()
	au BufNewFile,BufRead COMMIT_EDITMSG  call feedkeys('gg0')
	au BufNewFile,BufRead COMMIT_EDITMSG  setl spell
	au BufReadPost fugitive://*  set bufhidden=delete
augroup END
"-----------------------------------------------------------------------------



" "HTML"
augroup HTML
	au!
	au BufNewFile,BufRead *.htm   setf html
	au BufNewFile,BufRead *.html  setf html
	au FileType html              setl omnifunc=htmlcomplete#CompleteTags
	au Filetype html              call EnableCloseTag()
augroup END
"-----------------------------------------------------------------------------



" "Javascript"
augroup JavaScript
	au!
	au FileType javascript  setl omnifunc=javascriptcomplete#CompleteJS
augroup END
"-----------------------------------------------------------------------------



" "Markdown"
augroup MarkDown
	au!
	au FileType markdown  setl omnifunc=htmlcomplete#CompleteTags
augroup END
"-----------------------------------------------------------------------------



" "Perl"
augroup Perl
	au!
	au FileType perl  setl omnifunc=syntaxcomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "PHP"
augroup PHP
	au!
	au BufNewFile,BufRead *.php  setf php
	au FileType php	             let php_minlines=500
	au FileType php              setl omnifunc=phpcomplete#CompletePHP
augroup END
"-----------------------------------------------------------------------------



" "Plain Text"
augroup PlainText
	au!
	au BufNewFile,BufRead *.txt  setf text
augroup END
"-----------------------------------------------------------------------------



" "Python"
augroup Python
	au!
	au FileType python  setl omnifunc=pythoncomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "Ruby"
augroup Ruby
	au!
	au FileType ruby  setl omnifunc=rubycomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "Shell Script"
augroup ShellScript
	au!
	au BufNewFile,BufRead *.sh  setf sh
	au BufWritePost *.sh        call MakeFileExecutable()
augroup END
"-----------------------------------------------------------------------------



" "Smarty Template Engine"
augroup Smarty
	au!
	au BufNewFile,BufRead *.tpl  setf html
augroup END
"-----------------------------------------------------------------------------



" "XML/XSL"
augroup XMLXSL
	au!
	au BufNewFile,BufRead *.xml   setf xml
	au BufNewFile,BufRead *.xsl   setf xml
	au BufNewFile,BufRead *.rss   setf xml
	au BufNewFile,BufRead *.atom  setf xml
	au FileType xml               setl omnifunc=xmlcomplete#CompleteTags
	au Filetype xml               call EnableCloseTag()
	au Filetype xsl               call EnableCloseTag()
augroup END
"-----------------------------------------------------------------------------



"}}}
" FUNCTIONS:"{{{
" ******************************************************************************

" "Reload Configurations"
if !exists("*Reload")
	function! Reload()
		so $MYVIMRC
		nohlsearch
		" Reapproximate hex color codes for terminal
		exe 'CSApprox'
		" Reapply Powerline color scheme
		call Pl#Load()
		call Msg('Vim Configuration Reloaded!')
	endfunction
endif
"-------------------------------------------------------------------------------



" "Delete Empty Buffers"
" From http://goo.gl/6OBjJ
function! DeleteEmptyBuffers()
	let empty = []
	let [i, n] = [1, bufnr('$')]
	while i <= n
		if bufexists(i) && bufname(i) == ''
			call add(empty, i)
		endif
		let i += 1
	endwhile
	if len(empty) > 0
		exe 'bdelete' join(empty, ' ')
	endif
endfunction
"-------------------------------------------------------------------------------



" "Clear Cache"
function! ClearCache()
	silent execute "!~/.vim/.aux/clear.sh &>/dev/null &"
	redraw!
	echo "Cache Cleared!"
endfunction
"-------------------------------------------------------------------------------



" "Restore Register"
function! RestoreRegister()
	if &clipboard == 'unnamed'
		let @* = s:restore_reg
	elseif &clipboard == 'unnamedplus'
		let @+ = s:restore_reg
	else
		let @" = s:restore_reg
	endif
	return ''
endfunction
"-------------------------------------------------------------------------------



" "Delete File"
function! DeleteFile()
  let l:delprompt = input('Are you sure? ')
  if l:delprompt == "y" || "Y"
    :echo delete(@%)
    :Kwbd
  else
    redraw!
    return
  endif
endfunction
"-------------------------------------------------------------------------------



" "Replace"
function! s:Repl()
	let s:restore_reg = @"
	return "p@=RestoreRegister()\<CR>"
endfunction
"-------------------------------------------------------------------------------



" "WinEnter Routine"
function! WinEnterRoutine()
	setl cursorline
	if g:cursorcolumnstate == 1
		setl cursorcolumn
	else
		setl nocursorcolumn
	endif
endfunction
"-------------------------------------------------------------------------------



" "WinLeave Routine"
function! WinLeaveRoutine()
	setl nocursorline
	setl nocursorcolumn
endfunction
"-------------------------------------------------------------------------------



" "Toggle On/Off"
" Prints a message of the current toggled state of various features.
function! ToggleOnOff(OptionName, OnOrOff)
	let OptionName = a:OptionName
	let OnOrOff = a:OnOrOff
	let OptionState = strpart("OffOn", 3 * OnOrOff, 3)
	echo OptionName . ": " . OptionState
endfunction
"-------------------------------------------------------------------------------



" "Toggle Auto Completion"
function! ToggleAutoComplete()
	if g:neocomplcache_disable_auto_complete == 1
		echo 'Auto Completion: On'
		let g:neocomplcache_disable_auto_complete = 0
		NeoComplCacheEnable
	else
		echo 'Auto Completion: Off'
		let g:neocomplcache_disable_auto_complete = 1
		NeoComplCacheDisable
	endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Cursor Column"
function! ToggleCursorColumn()
	if g:cursorcolumnstate == 0
		let g:cursorcolumnstate = 1
		setl cursorcolumn
		echo 'Cursor Column: On'
	else
		let g:cursorcolumnstate = 0
		setl nocursorcolumn
		echo 'Cursor Column: Off'
	endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Color Highlights"
function! ToggleColorHighlights()
	if g:ColorizerState == 1
		exe 'ColorClear'
		let g:ColorizerState = 0
		echo 'Color Highlights: Off'
	else
		exe 'ColorHighlight'
		let g:ColorizerState = 1
		echo 'Color Highlights: On'
	endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Maximized/Restore Window"
function! MaxRestoreWindow()
	if g:windowmaximized == 1
		let g:windowmaximized = 0
		wincmd =
		redraw!
		echo 'Windows Restored'
	else
		let g:windowmaximized = 1
		wincmd |
		wincmd _
		echo 'Window Maximized'
	endif
endfunction
"-------------------------------------------------------------------------------



" "Ctrl-P Custom Mappings""
function! MyCtrlPMappings()
	nnoremap <buffer><silent><C-c> :call <sid>DeleteBuffer()<CR>
endfunction
"-------------------------------------------------------------------------------



" "Ctrl-P Delete Buffer"
function! s:DeleteBuffer()
	exec "bd" fnamemodify(getline('.')[2:], ':p')
	exec "norm \<F5>"
endfunction"
"-------------------------------------------------------------------------------



" "Tab Size"
function! TabSize()
	let l:tabstop = 1 * input('Tab Size: ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call TabSummary()
endfunction
"-------------------------------------------------------------------------------



" "Tab Summary Report"
function! TabSummary()
		echo 'Current tab settings: '
		echo 'tabstop='.&l:ts
		echo 'shiftwidth='.&l:sw
		echo 'softtabstop='.&l:sts
		if &l:et
			echo 'expandtab'
		else
			echo 'noexpandtab'
		endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Rule"
function! ToggleRule()
	if g:rulestate == 0
		set colorcolumn=0
		let g:rulestate=1
		echo "Rule: Off"
	else
		set colorcolumn=+1
		let g:rulestate=0
		echo "Rule: On"
	endif
endfunction
"-------------------------------------------------------------------------------



" "Messages"
" Prints [long] message up to (&columns-1) length without the 'Press Enter'
" prompt.
function! Msg(msg)
	let x=&ruler | let y=&showcmd
	set noruler noshowcmd
	redraw
	echo a:msg
	let &ruler=x | let &showcmd=y
endfunction
"-------------------------------------------------------------------------------



" "Toggle Number Type"
function! g:ToggleNumberType()
	if(&relativenumber==1)
		echo 'Number Type: Normal'
		set number
		let g:numbertype=0
	else
		echo 'Number Type: Relative'
		set relativenumber
		let g:numbertype=1
	endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Numbers"
function! g:ToggleNumbers()
	if(g:numbertype==1)
		call g:ToggleRelativeNumbers()
	else
		call g:ToggleNormalNumbers()
	endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Normal Numbers"
function! g:ToggleNormalNumbers()
	if(&number==1)
		setlocal nonumber
	else
		setlocal number
	endif
	let OnOrOff=&number
	call ToggleOnOff("Line Numbers", OnOrOff)
endfunction
"-------------------------------------------------------------------------------



" "Toggle Relative Numbers"
function! g:ToggleRelativeNumbers()
	if(&relativenumber==1)
		setlocal norelativenumber
	else
		setlocal relativenumber
	endif
	let OnOrOff=&relativenumber
	call ToggleOnOff('Relative Line Numbers', OnOrOff)
endfunction
"-------------------------------------------------------------------------------



" "Toggle Folds"
function! ToggleFolds()
	if &foldenable==1
		set nofoldenable
		set foldcolumn=0
	else
		set foldenable
		set foldcolumn=5
	endif
	let OnOrOff=&foldenable
	call ToggleOnOff('Folds', OnOrOff)
endfunction
"-------------------------------------------------------------------------------



" "Strip Trailing Whitespace"
function! StripTrailingWhitespace()
	" Only strip if the b:noStripeWhitespace variable isn't set
	if exists('b:noStripWhitespace')
		return
	endif
	%s/\s\+$//e
endfunction
"-------------------------------------------------------------------------------



" "New Session"
function! NewSession()
	call inputsave()
	let SessionName = input('New Session Name: ')
	exe "SaveSession " . SessionName
endfunction
"-------------------------------------------------------------------------------



" "Set Help Environment"
function! HelpEnvironment()
	if &filetype == 'help'
		setl relativenumber
		nnoremap <silent><buffer><CR> <C-]>
		nnoremap <silent><buffer><BS> <C-T>
	else
		nnoremap <CR> i<CR><Esc>
		nnoremap <BS> i<BS><Right><Esc>
	endif
endfunction
"-------------------------------------------------------------------------------



" "Set NERDTree Environment"
function! NERDTreeEnvironment()
	setl foldcolumn=0
	nnoremap <silent><buffer>,, :NERDTreeClose<CR>
	nnoremap <silent><buffer><Leader>bb :NERDTreeClose<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set Gundo Environment"
function! GundoEnvironment()
	setl foldcolumn=0
	nnoremap <silent><buffer>,, :silent! bw __Gundo__ __Gundo_Preview__<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set QuickFix Environment"
function! QuickFixEnvironment()
	setl foldcolumn=0
	nnoremap <silent><buffer>,, :pclose<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set Vundle Environment"
function! VundleEnvironment()
	setl foldcolumn=0
	vert resize 50
	nnoremap <silent><buffer>,, :bw<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set Git Environment"
function! GitEnvironment()
	setl foldcolumn=0
	setl foldlevel=99
	nnoremap <silent><buffer>,, :bw<CR>
endfunction
"-------------------------------------------------------------------------------



" "Enable Close Tag"
" Close open tags automatically upon entering </
function! EnableCloseTag()
	so ~/.vim/bundle/closetag.vim/plugin/closetag.vim
endfunction
"-------------------------------------------------------------------------------



" "Current Session Status"
function! CurrentSession()
	let g:currSession = fnamemodify(v:this_session, ':t:r')
	return g:currSession
endfunction
"-------------------------------------------------------------------------------



" "Make File Executable"
function! MakeFileExecutable()
	exe "silent! !chmod +x %"
	redraw!
	call Msg('Written as an executable shell script!')
endfunction
"-------------------------------------------------------------------------------



" "Save Buffer View"
function! SaveView()
	if expand('%') != '' && &buftype !~ 'nofile'
		silent! mkview
	endif
endfunction
"-------------------------------------------------------------------------------



" "Load Buffer View"
function! LoadView()
	if expand('%') != '' && &buftype !~ 'nofile'
			silent! loadview
	endif
endfunction
"-------------------------------------------------------------------------------



" "Join"
function! Join()
	normal! $
	normal! l
	let l = line(".")
	let c = col(".")
	join
	call cursor(l, c)
	" TODO: make work w/repeat.vim
	" silent! call repeat#set("\<leader>jn",1:count)
endfunction
"-------------------------------------------------------------------------------



" "Find and Replace"
function! FindReplace()
	let CurrentWord=GetVisual()
	" Get search string.
	call inputsave()
	let  CurrentString = input('Search for: ', CurrentWord)
	if (empty(CurrentString))
	 return
	endif
	call inputrestore()

	" Get replace string.
	call inputsave()
	let  NewString = input('Search for: '.CurrentString.'   Replace with: ')
	call inputrestore()

	" Determine wether or not to search for whole word only.
	redraw!
	let option = confirm('Search for whole word only? ', "&Yes\n&No", 2)
	if option == 0
		echo 'Invalid response. Please try again.'
	elseif option == 1
		" Find exact matches.
		exe "%s/\\<".CurrentString."\\>/".NewString."/gc"
	elseif option == 2
		" Find any matches.
		exe "%s/".CurrentString."/".NewString."/gc"
	endif
endfunction

" Escape String
" Escape special characters in a string for exact matching. This is useful to
" copying strings from the file to the search tool Based on this
" http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
	let string=a:string
	" Escape regex characters
	let string = escape(string, '^$.*\/~[]')
	" Escape the line endings
	let string = substitute(string, '\n', '\\n', 'g')
	return string
endfunction

" Get Visual Selection
" Get the current visual block for search and replaces This function passed the
" visual block through a string escape function above. Based on
" - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
	" Save the current register and clipboard
	let reg_save = getreg('"')
	let regtype_save = getregtype('"')
	let cb_save = &clipboard
	set clipboard&

	" Put the current visual selection in the " register
	normal! ""gvy
	let selection = getreg('"')

	" Put the saved registers and clipboards back
	call setreg('"', reg_save, regtype_save)
	let &clipboard = cb_save

	"Escape any special characters in the selection
	let escaped_selection = EscapeString(selection)

	return escaped_selection
endfunction
"-------------------------------------------------------------------------------



" "Fold Text"
function! FoldText()
	let linecount = v:foldend-v:foldstart
	let line_count_string = ' '.linecount.' lines-|'
	let line = getline(v:foldstart)
	let line = substitute(line, '{'.'{{\|/\*{{'.'{\|/\*\|\*/\|"{{'.'{', ' ', 'g')
	let line = strpart(line, 0, windowwidth - len(line_count_string))
	let fillcharcount = &textwidth - len(line) - len(line_count_string) +0
	return line . repeat("-",fillcharcount) . line_count_string
	"<·>"
endfunction
"-------------------------------------------------------------------------------



" "CSS Fold Text"
" From Michael Wilber
" https://github.com/vim-scripts/CSS-one-line--multi-line-folding
function! CssFoldText()
  let line = getline(v:foldstart)
  let nnum = nextnonblank(v:foldstart + 1)
  while nnum < v:foldend+1
    let line = line . " " . substitute(getline(nnum), "^ *", "", "g")
    let nnum = nnum + 1
  endwhile
  return line
endfunction
"-------------------------------------------------------------------------------



" "Better Retab""
" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
"-------------------------------------------------------------------------------



" "Close Buffer Keep Window"
command! Kwbd call s:Kwbd(1)
function! s:Kwbd(kwbdStage)
	if(a:kwbdStage == 1)
		if(!buflisted(winbufnr(0)))
			bd!
			return
		endif
		let s:kwbdBufNum = bufnr("%")
		let s:kwbdWinNum = winnr()
		windo call s:Kwbd(2)
		execute s:kwbdWinNum . 'wincmd w'
		let s:buflistedLeft = 0
		let s:bufFinalJump = 0
		let l:nBufs = bufnr("$")
		let l:i = 1
		while(l:i <= l:nBufs)
			if(l:i != s:kwbdBufNum)
				if(buflisted(l:i))
					let s:buflistedLeft = s:buflistedLeft + 1
				else
					if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
						let s:bufFinalJump = l:i
					endif
				endif
			endif
			let l:i = l:i + 1
		endwhile
		if(!s:buflistedLeft)
			if(s:bufFinalJump)
				windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
			else
				enew
				let l:newBuf = bufnr("%")
				windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
			endif
			execute s:kwbdWinNum . 'wincmd w'
		endif
		if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
			execute "bd! " . s:kwbdBufNum
		endif
		if(!s:buflistedLeft)
			set buflisted
			set bufhidden=delete
			set buftype=
			setlocal noswapfile
		endif
	else
		if(bufnr("%") == s:kwbdBufNum)
			let prevbufvar = bufnr("#")
			if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
				b #
			else
				bn
			endif
		endif
	endif
endfunction
"-------------------------------------------------------------------------------



" "Line/Fold Movement"
function! MoveLineOrFoldUp()
	if winline() != 1
		normal ddkP
	else
		normal k
	endif
endfunction

function! MoveLineOrFoldDown()
	if winline() != line($)
		normal ddp
	else
		normal j
	endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle CSS Fold"
function! ToggleCSSFold()
	if g:cssfoldstate == 0
		let g:cssfoldstate = 1
		setl foldtext=CssFoldText()
		setl foldmethod=marker
		setl foldmarker={,}
		echo 'CSS Fold: On'
	else
		let g:cssfoldstate = 0
    setl foldtext=FoldText()
		setl foldmarker={{{,}}}
		setl foldmethod=marker
		echo 'CSS Fold: Off'
	endif
endfunction
"-------------------------------------------------------------------------------



" "Highlight Words"
" From S.Losh - https://github.com/sjl/dotfiles/blob/master/vim/vimrc
function! HiInterestingWord(n)
  normal! mz
  normal! "zyiw
  let mid = 86750 + a:n
  silent! call matchdelete(mid)
  let pat = '\V\<' . escape(@z, '\') . '\>'
  call matchadd("InterestingWord" . a:n, pat, 1, mid)
  normal! `z
endfunction
"-------------------------------------------------------------------------------



" "Close Unlisted Buffers"
function! CloseUnlistedBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
"-------------------------------------------------------------------------------



" "Close Inactive Buffers"
function! CloseInactiveBuffers()
  "List of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  "What tab page are we in?
  let l:currentTab = tabpagenr()
  try
    "Go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      "Go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        "Whatever buffer is in this window in this tab, remove it from
        "l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    "If there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    "Go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
"-------------------------------------------------------------------------------



" "Highlight Visual"
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
"-------------------------------------------------------------------------------



" "Close Diff"
function! CloseDiff()
	  if (&diff == 0 || getbufvar('#', '&diff') == 0)
        \ && (bufname('%') !~ '^fugitive:' && bufname('#') !~ '^fugitive:')
    echom "Not in diff view."
    return
  endif

  " close current buffer if alternate is not fugitive but current one is
  if bufname('#') !~ '^fugitive:' && bufname('%') =~ '^fugitive:'
    if bufwinnr("#") == -1
      b #
      bd #
    else
      bd
    endif
  else
    bd #
  endif
endfunction
"-------------------------------------------------------------------------------



"}}}
" WRAP:"{{{
" ******************************************************************************

" "Load Local Configurations"
if filereadable(expand('~/.vimrc.local'))
	so ~/.vimrc.local
endif
"-------------------------------------------------------------------------------



" "Todo/s, Fixme/s"
" TODO: session info in powerline
" TODO: create functions to toggle cursor column and line.
" TODO: Compile browser reload ahk script to exe.
" TODO: Configure NeoSnippets
"}}}
