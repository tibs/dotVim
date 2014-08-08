" .vimrc
"
" Based on the file supplied with VIM 6.3
" For an explanation of the standard parts that follow, see ``:help
" vimrc_example``

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" On Windows, it defaults to reading this in latin-1, which doesn't allow
" for some characters we use in listchars
scriptencoding utf-8

" =============================================================================
" VUNDLE START
" =============================================================================
filetype on		" because sometimes on Mac OS X, off before on causes problems
filetype off		" must do this before Vundle business

" Vim 7.2 without some patch or other doesn't support current vundle.
" The MacVim I was using was OK, but the Apple vim wasn't. So upgrade
" the MavVim to 7.3 and test for that...
if version >= 703
  " Set the runtime path to include Vundle
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  " Start off with vundle itself
  Plugin 'gmarik/Vundle.vim'
  " Then various things mirrored at http://vim-scripts.org/vim/scripts.html

  " I want pyflakes/pep8 checking, and the current recommended way to get
  " this appears to be via Syntastic
  "
  " Remember to "pip install flake8" in the external environment...
  "Plugin 'https://github.com/scrooloose/syntastic.git'

  " The original pyflakes-vim is now pseudo-deprecated, as the author prefers
  " syntastic, but it *is* still available, and in some ways the nicest
  " solution
  Plugin 'https://github.com/kevinw/pyflakes-vim'

  " Or just use flake8
  " <F7> to run the checker
  "Plugin 'https://github.com/nvie/vim-flake8'

  " flake8-vim actually uses frosted
  "Plugin 'https://github.com/andviro/flake8-vim'

  " Switch between buffers
  "Plugin 'bufexplorer.zip'

  " VimReStructuredText
  "Plugin 'VST'

  " Yet another indent finder, almost
  "Plugin 'yaifa.vim'

  " Emacs like gdb interface to cterm vim
  "Plugin 'vimgdb'

  " Enhanced version of the python syntax highlighting script
  "Plugin 'python.vim--Vasiliev'

  "Plugin 'RST-Tables'
  " It looks as if vim-tables is more sophisticated than RST-Tables
  "   http://dhruvasagar.com/2013/03/17/vim-table-mode
  " It depends on Tabular, so...
  "Plugin 'tabular'
  "Plugin 'vim-tables'

  "Plugin 'scratch'

  " Tree-view of the undo history
  "   http://sjl.bitbucket.org/gundo.vim/
  "Plugin 'gundo'
  
  " A Python omnicompletion utility
  "Plugin 'pysmell.vim'
  
  " Directory Browser
  "Plugin 'ls.vim'

  " Show all lines in the buffer containing word (grep buffer)
  "Plugin 'occur.vim'

  " Easy session management for gvim
  "Plugin 'sessions.vim--Boland'

  " A plugin for visually displaying indent levels in Vim
  "   https://github.com/nathanaelkane/vim-indent-guides
  "Plugin 'Indent-Guides'
  
  " Colour scheme related
  " First, a template for building one's own colour scheme
  "Plugin 'colorscheme_template.vim'
  " Then some specific examples
  "Plugin 'habiLight'
  "Plugin 'pyte'
  "Plugin 'proton'
  "Plugin 'sienna'

  " Consider vim-abolish from Tim Pope: easily search for, substitute, and
  " abbreviate multiple variants of a word
  "   https://github.com/tpope/vim-abolish
  "Plugin 'vim-abolish'
  " Also, https://github.com/tpope/vim-scriptease, A Vim plugin for Vim plugins
  "Plugin 'vim-scriptease
  
  call vundle#end()
  filetype plugin indent on	" and this required at end of vundle stuff
endif

" Brief help
"
" :PluginInstall  - install bundles (won't update installed)
" :PluginInstall! - update if installed
"
" :Plugin foo    - search for foo
" :Plugins! foo   - refresh cached list and search for foo
"
" :PluginClean    - confirm removal of unused bundles
" :PluginClean!   - remove without confirmation
"
" or, from the command line, something like:
"
"     vim +PluginInstall +qall
"
" see :h vundle for more details
" or wiki for FAQ
" Note: comments after Plugin command are not allowed..
" =============================================================================
" VUNDLE END
" =============================================================================

" Choose a specific Python syntax checker...
" By default, checks are run when the file being edited is written out.
let g:syntastic_python_checkers=['flake8']

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Remove all autocommands for the current group, so we don't
  " define them all *again* if this file is run twice
  " (see :help autocmd)
  autocmd!

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType rst setlocal textwidth=78

  " I find it easier to read Makefiles with 8 character tabs
  " (and, of course, they must *actually* be tabs)
  autocmd FileType make set noexpandtab shiftwidth=8

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"  syntax on
"  set hlsearch
"endif
"
" Note that if I select 'syntax on' before the autocmd fiddling above
" then it seems to get ignored, so do it here (where it doesn't).
"
" My terminal doesn't seem to provide t_Co, but I normally use colour
" terminals, so let's assume the best:
syntax on
" I still want hightlighting of the last used search pattern
set hlsearch

" My own additions
set hidden              " buffer becomes 'hidden' when abandoned
set ignorecase		" ignore case in searching
set smartcase		" except when upper and lower case letters are mixed
set laststatus=2        " always have a status line, even with only one window
if has('mouse')
	set mouse=a	" support the mouse, if possible, in non-GUI mode
endif

" Enable showing of "listchars" with 'set list' (F4 will work if the Cream
" plugin is provided)
"
" eol:c				character to show at end of line
" tab:xy			first char at tab posn, second to fill after it
" trail:c			trailing spaces
" extends:c			if wrap is off, show at right of line that extends right
" precedes:c		if wrap is off, show at left of line that extends left
" conceal:c			if conceallevel is 1, show in place of concealed text
" nbsp:c			show for a non-breaking space
"
" NonText    highlight is used for eol, extends and precedes
" SpecialKey highlight is used for nbsp, tab and trail
"
" May want scriptencoding utf-8 at the top of the .vimrc
"
" Ideas are:
"
" eol:¶
" tab:»·
" trail:·
" extends:»,precedes:«
" nbsp:¬				- u00ac
" tab:⡁· 				- u2841 and middle dot
"
" Unicode characters can be inserted by typing ctrl-vu followed by the 4 digit
" hexadecimal code.
"
" newline:⤦				- u2926
" tab:➟					- u279f
" tab:▸					- u25b8
"
"set listchars=tab:\|\ ,eol:Â¶,trail:Â·,precedes:â¹,extends:âº
set listchars=tab:\|·,trail:·,precedes:<,extends:>,nbsp:◇

" Stop vim auto-indenting when pasting
" This is ignored by gvim, which can tell when the user is pasting stuff
set paste

if has("autocmd")

  " From http://vim.wikia.com/wiki/Highlight_unwanted_spaces:
  "
  "   If your goal is to:
  "
  "    1. highlight trailing whitespace in red
  "    2. have this highlighting not appear whilst you are typing in insert mode
  "    3. have the highlighting of whitespace apply when you open new buffers 
  "
  "   then the following 6 commands are what you should put into your .vimrc.
  "highlight ExtraWhitespace ctermbg=red guibg=red
  "match ExtraWhitespace /\s\+$/
  "autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  "autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  "autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  "autocmd BufWinLeave * call clearmatches()
  "   
  " Show trailing whitepace and spaces before a tab:
  "":autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  "":autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
  :autocmd Syntax * syn match Todo /\s\+$\| \+\ze\t/ containedin=ALL

  " In C files, I'd like to highlight all characters beyound virtual
  " column 80. Following the example given in ``:help match``, and
  " tip 810:
  " - define a new highlight group
  highlight rightMargin term=bold ctermbg=cyan guibg=cyan
  " - and use it to match our pattern in the current window
  "   (note that the 'last' match used wins...)
  "
  if version >= 703
	  set colorcolumn=80
  else
	  " Alec suggests that:
	  autocmd FileType c,cpp exec 'match rightMargin /.\%>80v/'
	  " may work better (and is simpler) than my original:
	  "autocmd BufNewFile,BufRead,BufEnter,FilterReadPost,FileReadPost *.c,*.h exec 'match rightMargin /.\%>80v/'
  endif
endif

" An alternative (better?) way to highlight whitespace errors:
let c_space_errors = 1
let java_space_errors = 1
let python_highlight_space_errors = 1
let python_highlight_indent_errors = 1

" From the comments to Tip 2, %/ can be used in command mode to insert the
" current file's directory
cmap %/ <C-R>=expand("%:p:h")."/"<cr>

if has('unix')
	let s:running_as = 'unix'
elseif has('mac') || has('macunix')
	let s:running_as = 'mac'
elseif has('win16') || has('win32') || has('dos16') || has('dos32')
	let s:running_as = 'dos'
else
	let s:running_as = ''
endif
function! FileFormatFlag()
	if &fileformat == s:running_as
		return ''
	else
		return '<' . &fileformat . '>'
	endif
endfunction

" The standard statusline doesn't show the filetype, or whether the
" file contains non-standard line endings. Unfortunately, modifying
" the statusline means redefining the whole thing
set statusline=
"set statusline+=%-3.3n\ 		" buffer number, space=separator
set statusline+=%<			" truncate (following) on left
set statusline+=%f\ 			" file name, space=separator
set statusline+=%y			" [filetype]
set statusline+=%m			" [modified]
set statusline+=%r			" [readonly]
" set statusline+=\<%{&fileformat}\>	" <fileformat>
set statusline+=%{FileFormatFlag()}	" <fileformat> if not right for this platform
set statusline+=\ 			" don't let the preceding run into the following
set statusline+=%=			" right align the following
set statusline+=%-14.(%l,%c%V%)\ %P	" ruler
" (basically, I've taken the example from ``:help statusline`` and replaced
" the ``%h`` by ``%y``, and added the display of the ``fileformat``, to allow
" me to tell when I've got CR/LF files...)

" For C indentation policies, see ~/.vim/indent/c.vim

" Vim7 introductions
"if ! has('gui')
"	" When entering insert mode:
"	let &t_SI = "\<Esc>]12;purple\x7"
"	" When exiting insert mode
"	let &t_EI = "\<Esc>]12;blue\x7"
"endif

" In normal mode, insert a three-line datestamp, as used in my log file
" -------------------- 
" The first example leave the cursor in the inserted text
"nmap <leader>today "=strftime("%F%n==========%n%A %d %B%n")<CR>P 

" This (perhaps cruder) version does not
nmap <leader>today :execute "normal i" . strftime("%F%n==========%n%A %d %B%n")<Esc>

function! EndLine()
    " If the filetype is already "rst" (presumably because my .vimrc made it
    " so), then embed that into the file as well (naughty but nice)
    if &filetype == "rst"
	  call append(line('$'), ".. vim: set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab:")
	  set tabstop=8 softtabstop=2 shiftwidth=2 expandtab
    elseif &filetype == "text"
	  call append(line('$'), ".. vim: set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab:")
	  set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab
    elseif &filetype == "txt"
	  call append(line('$'), ".. vim: set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab:")
	  set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab
    else
	  call append(line('$'), "# vim: set tabstop=8 softtabstop=4 shiftwidth=4 expandtab:")
	  set tabstop=8 softtabstop=4 shiftwidth=4 expandtab
    endif
endfunction

" Insert a common trailing line at the end of a text file
nmap <leader>endline :call EndLine()<Return>

" Show line numbers
set number

" Make all my backup files go into a common directory
"
"   For Unix and Win32, if a directory ends in two path separators "//" or
"   "\", the swap file name will be built from the complete path to the file
"   with all path separators substituted to percent '%' signs. This will
"   ensure file name uniqueness in the preserve directory.
"
set backupdir=~/.vim-backups//,.
set directory=~/.vim-backups//,.

" Experimentally, make ESC remove incremental search (hlsearch) highlighting, as well
" as what it normally does - i.e., do nohlsearch
"nnoremap <esc> :noh<return><esc>

" Inspired by sensible.vim (at https://github.com/tpope/vim-sensible/)
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
