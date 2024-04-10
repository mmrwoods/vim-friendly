" Note: complicated conditions to check whether to perform fallback filetype
" detection are required due the way Vim loads ftdetect scripts from packages.
" See commit message for a detailed explanation.

function! FriendlyFTDetect()
  if ( empty(&ft) && !exists("b:did_friendly_ftdetect") ) || ( !did_filetype() && &ft ==# 'conf' )
    let b:did_friendly_ftdetect = 1
    if getline(1) =~ '^{' && getline('$') =~ '^}' && getline(2) =~ '^\s\+"[^"]\+"\s*:'
      setfiletype FALLBACK json
    elseif getline(1) =~ '^%YAML'
      setfiletype FALLBACK yaml
    elseif getline(1) =~ '^---' && getline(2) =~ '^\(\w\S\+:\|\-\s\+\w\+\)'
      setfiletype FALLBACK yaml
    elseif getline(1) =~ '^\(\w\S\+:\|\-\s\+\w\+\)' && getline(2) =~ '^\s\+\(\w\S\+:\|\-\s\+\S\+\)'
      setfiletype FALLBACK yaml
    else
      let lines = getline(1, min([line("$"), 50]))
      if match(lines, '^\[.*\]$') != -1 && match(lines, '^\s*\w\+\s*=\s*\(\w\|\"\)') != -1
        if match(lines, '^\s*;') != -1
          setfiletype FALLBACK dosini
        elseif match(lines, '^\s*#') != -1
          setfiletype FALLBACK confini
        else
          setfiletype FALLBACK dosini
        end
      else
        let lines = getline(1, min([line("$"), 10]))
        if match(lines, '^\(\a\+\s\+\)\{3}\a\+') != -1
          setfiletype FALLBACK text
        endif
      endif
    endif
  endif
endfunction

" Run fallback filetype detection for dotfiles and files with no extension
autocmd BufNewFile,BufRead .* call FriendlyFTDetect()
autocmd BufNewFile,BufRead *\(.*\)\@<! call FriendlyFTDetect()
