" Compatibility hacks, loaded from VimEnter autocmd in plugin/friendly.vim

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

" Disable friendly git commit editor if commitia plugin installed
" See https://github.com/rhysd/committia.vim
if exists('g:loaded_committia')
  augroup friendly_gitcommit | au! | augroup END
endif

" Disable friendly swap file handling if autoswap plugin installed
" See https://github.com/gioele/vim-autoswap
if exists('g:loaded_autoswap')
  augroup friendly_autoswap | au! | augroup END
endif
