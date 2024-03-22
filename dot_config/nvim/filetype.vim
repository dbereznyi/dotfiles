" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.rgbds		setfiletype rgbds
  au! BufRead,BufNewFile *.tera		setfiletype ttl
augroup END
