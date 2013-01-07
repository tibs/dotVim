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

" =============================================================================
" VUNDLE START
" =============================================================================
filetype on		" because sometimes on Mac OS X, off before on causes problems
filetype off		" must do this before vundle business

" Vim 7.2 without some patch or other doesn't support current vundle.
" The MacVim I was using was OK, but the Apple vim wasn't. So upgrade
" the MavVim to 7.3 and test for that...
if version >= 703
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
  
  " Start off with vundle itself
  Bundle 'gmarik/vundle'
  " Then various things mirrored at http://vim-scripts.org/vim/scripts.html
  Bundle 'bufexplorer.zip'
  " VimReStructuredText
  Bundle 'VST'
  " Yet another indent finder, almost
  Bundle 'yaifa.vim'
  "
  Bundle 'vimgdb'
  Bundle 'python.vim--Vasiliev'
  Bundle 'RST-Tables'
  Bundle 'scratch'
  
  "Bundle 'pyflakes.vim'
  "Bundle 'pysmell.vim'
  
  Bundle 'ls.vim'
  Bundle 'occur.vim'
  Bundle 'sessions.vim--Boland'
  Bundle 'Indent-Guides'
  
  " Colour scheme related
  " First, a template for building one's own colour scheme
  Bundle 'colorscheme_template.vim'
  " Then some specific examples
  Bundle 'habiLight'
  Bundle 'pyte'
  Bundle 'proton'
  Bundle 'sienna'
  
  filetype plugin indent on	" and this required at end of vundle stuff
endif

" Brief help
"
" :BundleInstall  - install bundles (won't update installed)
" :BundleInstall! - update if installed
"
" :Bundles foo    - search for foo
" :Bundles! foo   - refresh cached list and search for foo
"
" :BundleClean    - confirm removal of unused bundles
" :BundleClean!   - remove without confirmation
"
" see :h vundle for more details
" or wiki for FAQ
" Note: comments after Bundle command are not allowed..
" =============================================================================
" VUNDLE END
" =============================================================================


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
"set listchars=tab:\|\ ,eol:¶,trail:·,precedes:‹,extends:›
set listchars=tab:\|�,trail:�,precedes:<,extends:>

if has("autocmd")
  " Show trailing whitepace and spaces before a tab:
  ":autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  ":autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
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
    elseif &filetype == "txt"
	  call append(line('$'), ".. vim: set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab:")
	  set tabstop=8 softtabstop=2 shiftwidth=2 expandtab
    else
	  call append(line('$'), "# vim: set tabstop=8 softtabstop=4 shiftwidth=4 expandtab:")
	  set tabstop=8 softtabstop=4 shiftwidth=4 expandtab
    endif
endfunction

" Insert a common trailing line at the end of a text file
nmap <leader>endline :call EndLine()<Return>

" Experimentally, make ESC remove incremental search (hlsearch) highlighting, as well
" as what it normally does - i.e., do nohlsearch
"nnoremap <esc> :noh<return><esc>
