" Detect specialised file types before Vim tries to do so
if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	" I can't think of a subtler way of detecting fluxbox files
	au! BufRead,BufNewFile ~/.fluxbox/*	setfiletype fluxbox
augroup END
