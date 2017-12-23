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

" Vim wants a Posix compatible shell, which fish is not.
" Note that this will also affect the shell launched by ``:sh[ell]``
if &shell =~# 'fish$'
    set shell=sh
endif

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

  " Let Vundle manage itself - this is required
  Plugin 'VundleVim/Vundle.vim'
  " Then various things mirrored at http://vim-scripts.org/vim/scripts.html

  " Let's try using Tim Pope's fugitive git wraper
  Plugin 'tpope/vim-fugitive'

  " I want pyflakes/pep8 checking, and the current recommended way to get
  " this appears to be via Syntastic
  "
  " Remember to "pip install flake8" in the external environment...
  "Plugin 'https://github.com/scrooloose/syntastic.git'

  " The original pyflakes-vim is now pseudo-deprecated, as the author prefers
  " syntastic, but it *is* still available, and in some ways the nicest
  " solution
  "Plugin 'https://github.com/kevinw/pyflakes-vim'

  " Or just use flake8
  " <F7> to run the checker
  "Plugin 'https://github.com/nvie/vim-flake8'

  " flake8-vim actually uses frosted
  "Plugin 'https://github.com/andviro/flake8-vim'

  if version >= 800
    " ALE is asynchronous linting, so needs vim 8 to work
    Plugin 'https://github.com/w0rp/ale.git'
    let g:ale_linters = { 'python': ['flake8'], }
    " Make it obvious which linter is reporting a problem, in case there are
    " multiple linters being run
    let g:ale_echo_msg_format = '%linter% says %s'
    " Set command line options for flake8
    let g:ale_python_flake8_options = '--max-line-length=120'
    " And let's always have the sign gutter, to stop text jumping around
    let g:ale_sign_column_always = 1
  endif

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

  " A better (one hopes) Python indentation mode.
  " It tries to do the following properly:
  "
  " foobar(foo,
  "     bar)
  "
  " and:
  "
  " foobar(
  "    foo,
  "    bar
  " )
  Plugin 'Vimjas/vim-python-pep8-indent'

  " Support for fish shell
  Plugin 'dag/vim-fish'

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
set t_Co=256	" Really, assert we've got 256 colours (!)
" See :help xterm-color for more information on this, and how to do it in
" a more resilient way.
" Also note we need to set t_Co before doing syntax on
syntax on
" I still want hightlighting of the last used search pattern
set hlsearch

" My own additions
set hidden              " buffer becomes 'hidden' when abandoned
set ignorecase		" ignore case in searching
set smartcase		" except when upper and lower case letters are mixed
set laststatus=2        " always have a status line, even with only one window
" Support the mouse, if possible, in non-GUI mode
if has('mouse')
    set mouse=a
endif
" See http://stackoverflow.com/questions/7000960 for some background on how
" this changed with/after vim 7.3.632
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

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
set listchars=tab:\|·,trail:·,precedes:<,extends:>,nbsp:◇
"
" or:
"   set listchars=tab:⇥\ ,nbsp:·,trail:␣,extends:▸,precedes:◂
" or:
"   set list listchars=tab:»¯,trail:°,extends:»,precedes:«
"   highlight NonText ctermfg=DarkRed
" or just:
"   set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Stop vim auto-indenting when pasting
" This is ignored by gvim, which can tell when the user is pasting stuff
"
"set paste
"
" However, note that 'set paste' stops cmap from working, and thus my '%/'
" binding won't work. An alternative is to have a way to toggle pastemode,
" such as:
"
"  set pastetoggle=<F10>
"
" or even:
"
"  map <F10> :set paste!<CR>
"
" However, http://stackoverflow.com/questions/5585129 suggests that modern
" terminals that support "bracketed paste mode" may know how to tell the
" editor what to do, in which case we can do:
"if &term =~ "xterm.*"
"    let &t_ti = &t_ti . "\e[?2004h"
"    let &t_te = "\e[?2004l" . &t_te
"    function XTermPasteBegin(ret)
"        set pastetoggle=<Esc>[201~
"        set paste
"        return a:ret
"    endfunction
"    map <expr> <Esc>[200~ XTermPasteBegin("i")
"    imap <expr> <Esc>[200~ XTermPasteBegin("")
"    cmap <Esc>[200~ <nop>
"    cmap <Esc>[201~ <nop>
"endif
"
" The following is taken from https://github.com/ConradIrwin/vim-bracketed-paste/blob/master/plugin/bracketed-paste.vim
" ============================================================================
" Code from:
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" then https://coderwall.com/p/if9mda
" and then https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim
" to fix the escape time problem with insert mode.
"
" Docs on bracketed paste mode:
" http://www.xfree86.org/current/ctlseqs.html
" Docs on mapping fast escape codes in vim
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim

if !exists("g:bracketed_paste_tmux_wrap")
  let g:bracketed_paste_tmux_wrap = 1
endif

function! WrapForTmux(s)
  if !g:bracketed_paste_tmux_wrap || !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
" ============================================================================

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
	  " The ctermbg colour is by experimentation!
	  highlight colorcolumn term=reverse ctermbg=217 guibg=LightRed
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

" Return:
" * '(<current git branch>)' if there is one
" * '(<8 chars of the SHA1>)' of the current commit if there is not
" * '' if we're not in git
function! GitBranch()
	let s:branch = fugitive#head(8)
	if s:branch == ''
		return ''
	else
		return '(' . s:branch . ')'
	endif
endfunction

" The standard statusline doesn't show the filetype, or whether the
" file contains non-standard line endings. Unfortunately, modifying
" the statusline means redefining the whole thing
set statusline=
"set statusline+=%-3.3n\ 		    " buffer number, space=separator
set statusline+=%<			    " truncate (following) on left
set statusline+=%f\ 			    " file name, space=separator
set statusline+=%{GitBranch()}		    " (<branch>) or (<sha1[:8]>) or nothing
set statusline+=%y			    " [<filetype>]
set statusline+=%m			    " [+] if modified
set statusline+=%r			    " [RO] if readonly
" set statusline+=\<%{&fileformat}\>	    " <fileformat>
set statusline+=%{FileFormatFlag()}	    " <fileformat> if not right for this platform
set statusline+=\ 			    " don't let the preceding run into the following
set statusline+=%=			    " right align the following
set statusline+=%-14.(%l,%c%V%)\ %P	    " ruler
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

function! PDB()
    " Insert the PDB magic line
    call append(line('.'), "import pdb; pdb.set_trace()")
endfunction

" Insert our PDB magic on the next line
" ...it won't be indented correctly, but it helps me remember the method to
" call
nmap <leader>PDB :call PDB()<Return>

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
