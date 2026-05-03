" Compatibility hacks, loaded from VimEnter autocmd in plugin/friendly.vim

if exists("g:loaded_friendly_compat")
  finish
endif
let g:loaded_friendly_compat = 1

" Disable friendly hlsearch if vim-cool or nohlsearch plugin installed
" See https://github.com/romainl/vim-cool
" And https://github.com/vim/vim/pull/15042
" Note: nohlsearch added in patch 9.1.0496 but g:loaded_nohlsearch guard
" added in patch 9.1.0645, patches copied to Neovim but not yet released
if has('patch-9.1.0496') && !has('patch-9.1.0645') && !empty(findfile('plugin/nohlsearch.vim', &rtp))
  let g:loaded_nohlsearch = 1
endif
if exists('g:loaded_cool') || exists('g:loaded_nohlsearch')
  augroup friendly_hlsearch | au! | augroup END
endif

" Disable friendly swap file handling if autoswap plugin installed
" See https://github.com/gioele/vim-autoswap
if exists('g:loaded_autoswap')
  augroup friendly_autoswap | au! | augroup END
endif

" Disable friendly git commit editor if commitia plugin installed
" See https://github.com/rhysd/committia.vim
if exists('g:loaded_committia')
  augroup friendly_git_editor | au! | augroup END
endif

" Lexima overwrites existing CR mappings, unlike auto-pairs which wraps them
" Restore friendly CR mapping on buffers where list formatting enabled and no
" buffer local mapping exists (Note: bullets.vim uses buffer local mappings)
if exists('g:loaded_lexima')
  augroup friendly_compat_lexima
    autocmd BufEnter *
      \ if match(&formatoptions, 'n') != -1 && !maparg('<CR>', 'i', 0, 1)['buffer'] |
      \   inoremap <buffer> <expr> <CR> (pumvisible() ? "\<C-y>" : '<C-]><C-R>=FriendlyCR()<CR>') |
      \ endif
  augroup END
endif
