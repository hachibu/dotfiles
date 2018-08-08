function! s:SetScriptFiletype()
  let l:line = getline(1)
  if l:line =~ "crystal$"
    setfiletype crystal
  elseif l:line =~ "racket$"
    setfiletype racket
  endif
endfunction

if did_filetype()
  finish
else
  call s:SetScriptFiletype()
endif
