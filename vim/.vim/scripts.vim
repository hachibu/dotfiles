if did_filetype()
  finish
endif

if getline(1) =~ '^#!.*\<crystal\>'
  setfiletype crystal
elseif getline(1) =~ '^#!.*\<racket\>'
  setfiletype racket
endif
