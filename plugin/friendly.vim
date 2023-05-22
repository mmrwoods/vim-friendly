" Prevent duplicate loading, allows overriding from vimrc
if exists("g:loaded_friendly")
  finish
endif
let g:loaded_friendly = 1

set nocompatible                  " Disable vi compatibility (must come first)

set encoding=utf-8                " Default to UTF8, don't use value from $LANG

set nofixeol                      " Disable fixeol by default, use .editorconfig

set cursorline                    " Highlight the cursor line

set ttyfast                       " Assume a fast terminal connection

runtime macros/matchit.vim        " Extended matching with %, see h: matchit

syntax enable                     " Turn on syntax highlighting
filetype plugin indent on         " Turn on file type detection and indentation

set autoindent                    " Auto-indent if no file type specific indent

set expandtab                     " Insert spaces when hitting <Tab>

set shiftwidth=2                  " Default 2-space indent when shifting lines

set softtabstop=-1                " Use shiftwidth with <Tab> and <Backspace>

set smarttab                      " Use shiftwidth with <Tab> at start of line

set showcmd                       " Show incomplete commands as you type

set backspace=indent,eol,start    " Intuitive backspacing in insert mode

set hidden                        " Allow hidden buffers with unsaved changes

set wildmenu                      " Enhanced command line completion
set wildmode=list:longest,full    " Complete files like a shell (similar to zsh)

set ignorecase                    " Ignore case when searching
set smartcase                     " Except when search contains capital letters
if exists("&tagcase")
  set tagcase=followscs           " Update tag search to to the same
endif
set infercase                     " And infer case when doing keyword completion

if exists("&fileignorecase")
  set fileignorecase              " Make file name completion case-insensitive
endif

if exists("&spelloptions")
  set spelloptions+=camel         " Make spell check split CamelCased words
endif

set number                        " Show line numbers in left margin
set ruler                         " Show cursor position in default status line

set hlsearch                      " Enable highlighting of search matches
set incsearch                     " And move to first match as you type

set nowrap                        " Turn off line wrapping by default
set scrolloff=1                   " Show context when scrolling vertically

set sidescroll=1                  " Scroll hoizontally one column at a time
set sidescrolloff=2               " Show context when scrolling horizontally

set title                         " Set the terminal's title

set belloff=all                   " No beeping, ever, not even visual

set confirm                       " Allow dialog to confirm an action
set autoread                      " Skip confirm for file changed outside vim
set writeany                      " Allow writing of any file without confirm

set laststatus=2                  " Show the status line all the time

set splitright                    " Open vertical splits to the right
set splitbelow                    " Open horizontal splits below

if has("balloon_eval")
  set noballooneval               " Disable slow and annoying tooltips
endif

" Disable syntax highlighting on very long lines, e.g. minified js, slow
" Often breaks highlighting on following lines, so don't set this too low
set synmaxcol=500

" Assume a 256 color terminal, ignore $TERM, makes things just work, even when
" terminal emulator is configured incorrectly or $TERM is overridden somewhere
set t_Co=256

" Suffixes that can be ignored when completing file names
set suffixes=.bak,~,.swp,.o,.info,.aux,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Patterns that should be ignored when expanding wildcards
set wildignore=*~,*.o,*.aux,*.dvi,*.pdf,*.gif,*.jpg,*.png,*.pyc,.DS_Store,*.egg*,.git,__pycache__

" Custom status line, show relative file path and file type
set statusline=%<%.99{expand('%:~:.')}\ %h%w%m%r\ %=\ %{&ft}\ %l\:\%-c\ %P

" Store windows, tabs, current directory, and buffer info in sessions
" Exclude blank to avoid issues with nofile & quickfix windows (e.g.
" NERDTree, Tagbar, Ack), which are not well supported by vim sessions
set sessionoptions=buffers,curdir,tabpages,winsize,winpos,resize

" Persist g:UPPERCASE variables in viminfo, used by plugins, e.g. sessionman
set viminfo^=!

" list mode characters used to display whitespace, toggle with :set list!
" note: only use basic latin and latin 1 supplement unicode characters to
" avoid missing glyphs, see https://github.com/tpope/vim-sensible/issues/57
set listchars=tab:»·,nbsp:¤,trail:·
if has("nvim") || has("patch-8.2.2454")
  set listchars+=lead:·
endif
if has("nvim") || has("patch-8.2.3424")
  set listchars+=multispace:·
endif

" Ins mode completion options - complete without menu if just one match,
" only complete to longest common match, don't use preview scratch window
set completeopt=menuone,longest

" Include dictionary words in completion menu when spellcheck is enabled
set complete+=kspell

" Disable completing keywords in included files, can make completion slow
set complete-=i

" Delete comment leader when joining commented lines
set formatoptions+=j

" When joining lines, use one space rather than two after punctuation
set nojoinspaces

" If using grep, at least ignore binaries and exclude some paths
set grepprg=grep\ -r\ -n\ -I\ --exclude=tags\ --exclude-dir=vendor\ --exclude-dir=node_modules\ --exclude-dir=.git\ $*\ /dev/null

" Reuse existing windows when opening files from the quickfix window
set switchbuf=useopen
if has("nvim") || has("patch-8.1.2315")
  set switchbuf+=uselast
endif

" Minimalist fold text, just show first line, no line count etc.
set foldtext=getline(v:foldstart)

" Override fillchars to avoid filling folded line with dashes
set fillchars=fold:\ ,vert:\|
if has("nvim") || has("patch-8.2.2508")
  set fillchars+=eob:~
endif

" Do not recognize octal numbers when adding/subtracting using CTRL-A
" and CTRL-X, e.g. make CTRL-A on "007" result in "008", not "010"
set nrformats-=octal

" Enable mouse support in normal, visual and insert modes
set mouse=nvi

" Copy to and paste from system clipboard
set clipboard=unnamed

" And to X11 primary selection if available
if has("unnamedplus")
  set clipboard+=unnamedplus
endif

" Default to a dark background if vim fails to detect the terminal bg
if exists("v:termrbgresp") && empty(v:termrbgresp)
  set background=dark
endif

" Use a less bare, more colourful, colorscheme by default if possible
try
  if &background ==# 'dark'
    colorscheme slate
  else
    colorscheme delek
  endif
catch
  colorscheme default
endtry

" Make Y act like D and C, i.e. yank until EOL rather than yank entire line
noremap Y y$

" And make delete key just delete, i.e. send text to blackhole register
nnoremap <Del> "_x
vnoremap <Del> "_x

" Don't use Q for Ex mode, except for Select mode, confusing for new users
" Revert with ":unmap Q".
map Q <nop>
sunmap Q

" Stop recording commands and opening the command history by accident
" See ":h q" and ":h q:" to understand exactly what this disables
" Revert with ":unmap q".
nnoremap q <nop>

" Retain selection after shifting highlighted lines in visual mode
vnoremap > >gv
vnoremap < <gv

" Allow windows & gnome shortcuts to shift lines (works on Mac too)
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Allow basic windows style editing shortcuts. Copied from mswin.vim but
" implements fewer shortcuts, in fewer modes, to avoid breaking things like
" CTRL-A/CTRL-X to add/subtract numbers and CTRL-V for visual block mode.
" For more extensive windows style editing shortcuts, see :help mswin.vim
"
" CTRL-C is Copy in visual mode
vnoremap <C-C> "+y
" CTRL-V is Paste in insert mode
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
" CTRL-Z is Undo in normal and insert modes
noremap <C-Z> u
inoremap <C-Z> <C-O>u
" CTRL-Y is Redo in normal and insert modes
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>
" CTRL-V is also Paste in terminal job mode
tnoremap <C-V> <C-W>"+

" Make backspace work with visual selections again. This used to work by
" default in version 8.1.1722, but upgrading to version 8.1.2234 broke it,
" without this mapping, backspacing in visual mode just moves the cursor.
vnoremap <BS> "_x

" Use CTRL-L to clear search highlighting and call :diffupdate,
" in addition to clearing & redrawing the screen, see :h CTRL-L
" Copied from vim-sensible, also included in Neovim defaults
if empty(mapcheck('<C-L>', 'n'))
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Allow undo of text deleted using CTRL-U in insert mode, see :h i_CTRL-U
" Coped from vim-sensible, also included defaults.vim and Neovim defaults
" See https://vim.fandom.com/wiki/Recover_from_accidental_Ctrl-U
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif

" Allow undo of text deleted using CTRL-W in insert mode, see :h i_CTRL-W
" Coped from vim-sensible, also included in Neovim, but not in defaults.vim
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" Only highlight search matches while search cmdline active. IMO this is just
" less confusing for new Vim users, even when CTRL-L is mapped to nohlsearch.
" Disable with ":augroup friendly_hlsearch | au! | augroup END"
augroup friendly_hlsearch
  au!
  au CmdlineEnter /,\?,: set hls   " Highlight all matches while searching
  au CmdlineLeave /,\?,: set nohls " Hide all matches when search completed
augroup END

" Use CTRL-H to toggle search highlighting (being able to see matches is
" really useful when operating on those matches using gn, see :help gn)
" Note: <Cmd> mapping required to work around CmdlineLeave to set nohls
" Could be done with <expr> mapping, but more convoluted, needs function
if has("nvim") || has("patch-8.2.1978")
  if empty(mapcheck('<C-H>', 'n'))
    nnoremap <C-H> <Cmd>set hlsearch!<CR>
  endif
endif

augroup friendly_filetypes
  au!
  " Turn on spell checking by default for some file types, and add some syntax
  " rules to skip URLs and upper case acronyms when checking spelling errors.
  " Syntax match rules for URLs and acronyms come from Anthony Panozzo's blog:
  " http://www.panozzaj.com/blog/2016/03/21/ignore-urls-and-acroynms-while-spell-checking-vim/
  autocmd FileType markdown,gitcommit,asciidoc,rst,rdoc
    \ setlocal spell |
    \ syntax match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell |
    \ syntax match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell

  " Enable syntax highlighting for long lines in git commits
  autocmd FileType gitcommit setlocal synmaxcol=0

  " Auto wrap and indent bulleted lists spanning multiple lines in git commits
  " Abuses Vim's comment formatting, see :h fo-table and :h format-comments
  " FIXME: might warrant a separate augroup so can be disabled independently
  autocmd FileType gitcommit setlocal comments=fb:*,fb:-
  autocmd FileType gitcommit setlocal formatoptions+=c

  " Override formatlistpat for git commmits to avoid indenting after line
  " starting with number followed by space. Copied from latest gitcommit
  " filetype plugin, see https://github.com/tpope/vim-git/commit/e7afd90a
  " FIXME: version check to avoid overriding after Vim runtime files updated?
  autocmd FileType gitcommit setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}]\\s\\+\\\|^\\s*[-*+]\\s\\+

  " Enable soft wrap for markdown, hard-wrapped markdown seems controversial,
  " and it's not worth arguing about (personally I think markdown should be
  " treated as source, and I will wrap at 80 if no other rules apply, but I
  " also respect other peoples' and teams' opinions and follow their rules)
  autocmd FileType markdown setlocal wrap linebreak

  " Disable yaml indentexpr from runtime files, too magical and confusing for
  " occasional use. See https://groups.google.com/g/vim_dev/c/vgNNI-pj7Gk?pli=1
  autocmd FileType yaml setlocal autoindent indentexpr=

  " Avoid error editing crontab: temp file must be edited in place
  autocmd filetype crontab setlocal nobackup nowritebackup
augroup END

" Only show cursorline in currently focused/active window
" Note: Both Buf{Enter,Leave} and Win{Enter,Leave} required to handle
" various edge cases with popups, same buffer in multiple windows etc.
" Disable with ":augroup friendly_cursorline | au! | augroup END"
augroup friendly_cursorline
  au!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave,BufLeave * setlocal nocursorline
augroup END

" Jump to last known cursor position when editing (except for git commits)
" Note: augroup name copied from Vim's defaults.vim, I don't really like it,
" but can't think of anything better at the moment - may change this later.
" Disable with ":augroup friendly_startup | au! | augroup END" (for now)
augroup friendly_startup
  au!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft != 'gitcommit' |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Diff a buffer with the file from which it was originally loaded, i.e.
" show changes you've made but not yet saved. See :h diff-original-file
" Revert with: ":delcommand DiffOrig"
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Assume a POSIX-compatible shell when shell type not specified, otherwise
" syntax highlighting falls back to Bourne shell. See help: ft-posix-syntax
" More info: see SetFileTypeSH function in $VIMRUNTIME/autoload/dist/ft.vim
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell')
  let g:is_posix = 1
endif

" autochdir when in insert mode for relative file path completion
" stolen from, damn I forget where, but I definitely stole it
" FIXME: remap i_CTRL-X_CTRL-F and use au CompleteDone instead?
" Disable with ":augroup friendly_autochdir | au! | augroup END"
augroup friendly_autochdir
  au!
  " set current directory on insert mode
  autocmd InsertEnter * let w:save_cwd = getcwd() | silent! lcd %:p:h
  " switch back to previous directory when leaving insert mode
  autocmd InsertLeave * if exists('w:save_cwd') | silent execute 'lcd' fnameescape(w:save_cwd) | endif
  " catch edge cases when leaving window or vim while in insert mode
  autocmd WinLeave * if exists('w:save_cwd') | silent execute 'lcd' fnameescape(w:save_cwd) | endif
  autocmd VimLeavePre * windo if exists('w:save_cwd') | silent execute 'lcd' fnameescape(w:save_cwd) | endif
augroup END

" Stupid simple tab completion, file path and keyword completion only
" Cribbed from Gary Bernhardt's vimrc and Akshay Hegde's VimCompletesMe
" For more elaborate completions, see :h 'ins-completion' or use coc.nvim
function! <SID>SimpleTab()
  let pos = getpos('.')
  let substr = matchstr(strpart(getline(pos[1]), 0, pos[2]-1), "[^ \t]*$")
  if empty(substr)
    return "\<tab>"
  elseif match(substr, '\/') != -1 && match(substr, '<\/') == -1
    return "\<c-x>\<c-f>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <expr> <tab> <SID>SimpleTab()

" Do the right thing with swap files, inspired by vim-autoswap
" Disable with ":augroup friendly_swapexists | au! | augroup END"
function! <SID>HandleSwapfile(filename, swapname)
  if getftime(a:swapname) < getftime(a:filename)
    " swapfile is older than file itself, just delete it
    let v:swapchoice = 'd'
  elseif executable('lsof')
    call system('lsof ' . a:swapname)
    if v:shell_error == 0
      " swapfile owned by another vim process, open readonly
      let v:swapchoice = 'o'
    else
      " swapfile seems to be the result of a crash, recover
      let v:swapchoice = 'r'
    endif
  endif
endfunction
augroup friendly_swapexists
  au!
  autocmd SwapExists * call <SID>HandleSwapfile(expand('<afile>:p'), v:swapname)
augroup END

" Show diff from git commit --verbose in a new vertical split
" Inspired by https://github.com/rhysd/committia.vim, but mostly copied
" from https://gist.github.com/aroben/d54d002269d9c39f0d5c89d910f7307e
" Disable with ":augroup friendly_commitsplit | au! | augroup END"
function <SID>GitCommitSplitDiff()
  " Save the contents of the z register
  let old_z = getreg("z")
  let old_z_type = getregtype("z")

  try
    call cursor(1, 0)
    let diff_start = search("^diff --git")
    if diff_start > 0
      " Move diff from commit message to the z register
      :silent .,$delete z
      :silent write
      call cursor(1, 0)
      " Paste from z register into a new vertial split
      vnew
      silent normal! V"zP
      " Configure the diff buffer
      setlocal filetype=diff buftype=nofile readonly nonumber noswapfile nomodified nomodifiable nofoldenable
      silent file COMMIT_DIFF
      " Get back to the commit message
      wincmd p
    endif
  finally
    " Restore the z register
    call setreg("z", old_z, old_z_type)
  endtry
endfunction
augroup friendly_commitsplit
  au!
  autocmd VimEnter COMMIT_EDITMSG call <SID>GitCommitSplitDiff()
  autocmd QuitPre COMMIT_EDITMSG windo if &ft == 'diff' | bwipeout | endif
augroup END
