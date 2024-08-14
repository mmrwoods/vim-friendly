" Friendly default colors for terminal Vim/Neovim
"
" Use habamax in supported Vim/Neovim versions, otherwise use slate with some
" improvements backported from Vim 9 and customised diff syntax highlighting.
" This isn't ideal as both of these color schemes assume a dark background,
" and are not guaranteed to work well with all terminals. It might be better
" to use a ansi color scheme to match the terminal colors. Jeff Kreeftmeijer's
" Dim is a great example, see https://github.com/jeffkreeftmeijer/vim-dim
"
" Note: although Neovim 0.8.0 includes the refreshed Vim color schemes, an
" issue in the code prevented them from working with Neovim prior to 0.8.1,
" see https://github.com/neovim/neovim/pull/20604
if ( has('patch-9.0.0') || has('nvim-0.8.1') )
  runtime colors/habamax.vim

  " Restore some habamax colors lost in Vim patch 9.1.0588
  " See https://github.com/vim/vim/pull/15267
  "
  " Bring back yellow title color for git commit messages, without this
  " columns exceeding the recommended max summary length are hard to see
  hi Title ctermfg=186 ctermbg=NONE cterm=bold
  " Bring back solid background for column separating vertically split
  " windows, which is, IMO, visually clearer and is also consistent with
  " the solid background status line separating horizontally split windows
  hi VertSplit ctermfg=243 ctermbg=243 cterm=NONE
elseif !has('nvim-0.8.0')
  runtime colors/slate.vim

  " Backport some improvements to 16 color slate from Vim 9
  hi ColorColumn ctermfg=white ctermbg=darkgrey cterm=NONE
  hi Comment ctermfg=darkgray ctermbg=NONE cterm=NONE
  hi FoldColumn ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Folded ctermfg=darkcyan ctermbg=NONE cterm=NONE
  hi Function ctermfg=yellow ctermbg=NONE cterm=NONE
  hi LineNr ctermfg=grey ctermbg=NONE cterm=NONE
  hi PmenuSel ctermfg=black ctermbg=darkyellow cterm=NONE
  hi Pmenu ctermfg=NONE ctermbg=darkgrey cterm=NONE
  hi PmenuSbar ctermfg=NONE ctermbg=black cterm=NONE
  hi PmenuThumb ctermfg=NONE ctermbg=yellow cterm=NONE
  hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
  hi SpellCap ctermfg=darkyellow ctermbg=NONE cterm=underline
  hi SpellLocal ctermfg=red ctermbg=NONE cterm=underline
  hi SpellRare ctermfg=darkcyan ctermbg=NONE cterm=underline
  hi Statement ctermfg=blue ctermbg=NONE cterm=bold

  " Ditch sign column background color, only highlight signs
  hi SignColumn ctermbg=NONE

  " Copy nice cursorline styles from 256 color slate in Vim 9
  " Friendly.vim and Neovim assume 256 color capable terminals
  hi CursorLine ctermbg=236 cterm=NONE
  hi CursorLineNr ctermbg=236 cterm=NONE

  " Tone down vimdiff colors a litte, more like habamax
  hi DiffAdd ctermfg=white ctermbg=darkgreen cterm=NONE
  hi DiffChange ctermfg=white ctermbg=darkgray cterm=NONE
  hi DiffDelete ctermfg=darkyellow ctermbg=NONE cterm=NONE
  hi DiffText ctermfg=white ctermbg=lightgrey cterm=NONE

  " Customise diff syntax colors, defaults link to other syntax groups, and
  " with slate added and removed lines end up as bold red and dark orange
  " Tweak other colors a little too, to match defaults from git and tig
  hi diffAdded ctermfg=green
  hi diffRemoved ctermfg=red
  hi diffChanged ctermfg=yellow
  hi diffLine ctermfg=magenta
  hi diffFile ctermfg=yellow
  hi diffIndexLine ctermfg=blue
  hi diffSubname ctermfg=blue
endif
