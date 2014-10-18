" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Sep 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the font to use
" - see the end
" set guifont=Courier\ 10\ Pitch\ 8
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
" set guifont=-misc-fixed-medium-r-normal-*-*-120-*-*-c-*-koi8-r

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  " -- For some reason, this always indicated that syntax was already on,
  " -- presumably because of the .vimrc setting it so, but in fact that
  " -- did *not* have the desired effect, and I had to do "syntax on"
  " -- by hand. Hmm.
  """if !exists("syntax_on")
    syntax on
  """endif

  " Switch on search pattern highlighting.
  set hlsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95
  highlight  StatusLine term=bold,reverse cterm=NONE ctermfg=White ctermbg=Black gui=NONE guifg=White guibg=Black
  highlight  StatusLineNC term=bold,reverse cterm=NONE ctermfg=White ctermbg=Black gui=NONE guifg=White guibg=DarkSlateGray

endif

" My own additions
if has('macunix')
	set guifont=Monaco:h12
elseif has('unix')
	if hostname() == "rocket.arg.sj.co.uk"
		set guifont=-misc-fixed-medium-r-normal-*-*-120-*-*-c-*-iso8859-15
	else
		set guifont=Monospace\ 8
		" or consider Bitstream Vera Sans Mono 9 or 8
	endif
	" I have a bigger screen now...
	set lines=75 columns=100
	"set lines=66 columns=100
else
	" Lucida Console is quite nice, but I have trouble distinguishing full
	" stop and comma, at least on Windows XP. Consolas is a bit "loose",
	" but the characters are terribly clear. So practicality beats purity.
	"set guifont=Lucida\ Console
	set guifont=Consolas
	set lines=50 columns=100
endif

" Experimentally, always show line numbers
set number
