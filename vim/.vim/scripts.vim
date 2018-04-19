if did_filetype()
  finish
endif

if getline(1) =~ '^#!.*\<crystal\>'
  setfiletype crystal
endif
