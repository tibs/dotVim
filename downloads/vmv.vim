"vim file for renaming files with the system 'mv' command
" Design:
" read list of files (possibly verify existance, read from stdin or file or
"    current directory, etc)
" store static meta-data
" setup enviroment
" 	trap line creation/deletion? maybe just forbid insert.
" 	setup autocmd for buffer write
" execute autocmd on buffer write that:
" 	reads meta data, errors if file doesn't exist (maybe offer to re-read?)
" 	calls 'mv'
" 	update metadata if not exiting.




" 	reads meta data, errors if file doesn't exist (maybe offer to re-read?)
function VMVOneLine()
	" assume current cursor position is the correct line, yank it to a
	" variable.
	let s:line=line(".")
" get line
	let s:dest=getline(s:line)
" get corresponding line from hidden buffer
	buffer! VMVMetaData
		let s:src=getline(s:line)
" update meta-data
		call setline(s:line,s:dest)
	bprevious

" Abort early if line was not modified.
	" This should perhaps be done before saving meta-data, but it's cleaner
	" here.
	if s:src == s:dest
		return
	endif

"	debug!
"	echo "source=".s:src
"	echo "dest=".s:dest
"	echo "line=".s:line
" test existance
	if getfperm(s:src) == ""
		echo "DIE! - file no longer exists, the error is essentialy the same as \"file was modified while being edited\""
		return
	endif
" call system(mv)
	if rename(s:src,s:dest)
"		error! renaming failed (no permissions?)
		echo "DIE! - renaming failed. TODO: tell user WHY renaming failed..."
	endif
endfunction


" Apply VMVonline to each line in the current buffer
" 	Note: v:cmdarg is irrelevant, we don't care about the filename (if any)
" 	and we're going to move the files to the byte-equivelent anyway, so we
" 	either don't care, or the rename command will take care of encoding for
" 	us.
function VMVBuffer()
	" Scan whole buffer for changes
	buffer! VMVMetaData
	let s:result=VMVScanBuf()
	bp
	if !s:result
		" Files don't exist, check "!" and give a warning message and return
		" if not.
		if !v:cmdbang
			" TODO maybe this should be a "throw"
			echo "Some of these files no longer exist (add ! to override)"
			return
		endif
	endif

	%call VMVOneLine()

"	Clear the "modified" option if we're the BufWriteCmd
	if s:cmd
		setlocal nomodified
	endif
endfunction

function VMVScanOneLine()
	let s:src=getline(".")
	echo "scanning:" . s:src 
	return getfperm(s:src) != ""
endfunction

" Scan stored buffer, make sure files still exist.
" Returns TRUE if all files exist for the current buffer.
function VMVScanBuf()
"	call VMVScanOneLine()
	return 1
endfunction



" setup enviroment
" 	trap line creation/deletion? maybe just forbid insert.
" 	setup autocmd for buffer write
" store static meta-data
"	currently, create second buffer, assuming buffer is open.
"Verify existance of a file for each line...
"if ! VMVScanBuf()
"	echo "INVALID: not all lines correspond to files"
"	quit!
"endif

" We are editing a list of files, if it's in a file with a name, we 
" will write that file out when the "write" command is given. If there 
" is no actual file we will pretend there is, but with a write autocmd
" instead of the built-in filewriting thing.
if strlen(expand("%"))
	autocmd BufWritePre * call VMVBuffer()
	let s:cmd=0
else
	file vmvscratch
	setlocal buflisted
	setlocal buftype=acwrite
	autocmd BufWriteCmd * call VMVBuffer()
	let s:cmd=1
endif

" Create new hidden buffer with the same contents to store our meta-data
normal 1GVGy
badd VMVMetaData
buffer! VMVMetaData
setlocal nobuflisted
setlocal buftype=nofile
setlocal bufhidden=hide
setlocal noswapfile
normal P
setlocal nomodified
bprevious

