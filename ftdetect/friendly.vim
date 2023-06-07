  " Set .asc to AsciiDoc as this is recognised by GitHub (Vim only recognises
  " .asciidoc and .adoc extensions by default, see $VIMRUNTIME/filetype.vim)
  autocmd BufRead,BufNewFile *.asc setfiletype asciidoc
