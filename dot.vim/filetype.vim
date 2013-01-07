" Detect specialised file types before Vim tries to do so
if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	" I'd prefer text files to be treated as reStructuredText
	au! BufRead,BufNewFile *.txt,*.text setfiletype rst
	" And similarly, some other standard files
	au! BufRead,BufNewFile README,INSTALL,COPYRIGHT setfiletype rst
	" I can't think of a subtler way of detecting fluxbox files
	au! BufRead,BufNewFile ~/.fluxbox/*	setfiletype fluxbox
augroup END
