# friendly.vim

Friendly defaults for Vim, if you are new to Vim, this is a good place to start.

Inspired by Tim Pope's [sensible.vim](https://github.com/tpope/vim-sensible),
but unconstrained by any ambition to be a universal set of defaults, this plugin
overrides some of Vim's default settings and adds a few other minor tweaks to
make the initial experience more friendly to newcomers, without going too crazy.

The settings have been extracted from my own vimrc, many of which are copied
from other people's vimrcs, tips from Vim's own documentation, Vim's built-in
defaults.vim, Tim Pope's sensible.vim and also from Neovim's defaults.

Ideally, everything here should be easy to override from your own vimrc. If you
find something is not easy to override, please submit an issue (or even better,
open a pull request).

## Requirements

Vim 8.1 or later, though some features are only supported by and enabled on
later versions. Some features might require "huge" Vim, which is probably what
you got when you installed Vim. Only tested on Mac and Debian, might work fine
on Windows too. Should also work with Neovim, but may need a little tweaking.

## Installation

Install as an optional plugin using Vim's built-in package support:

```
mkdir -p ~/.vim/pack/mmrwoods/opt
cd ~/.vim/pack/mmrwoods/opt
git clone https://github.com/mmrwoods/vim-friendly.git friendly
```

Add add this line to the start of your vimrc (e.g. ~/.vimrc):

```vim
packadd friendly
```

## Customisation

Make any changes you like after `packadd friendly` in your vimrc. Settings can
just be overridden, mappings can undone using `unmap` and friends, but autocmds
are a little tricky as you need to reset the autocmd group (at least for now).

```vim
packadd friendly

" override textwidth, 80 column default, wat???
set textwidth=120

" undo q <nop> mapping, I like recording commands
unmap q

" stop automatically clearing search highlighting
augroup friendly_hlsearch | exe 'au!' | augroup END
```

## FAQs

**Can I use this as a minimal vimrc for git commits?**

Yes, create a separate vimrc that adds friendly.vim and updates packpath to stop
other plugins apart from Vim's own runtime plugins from loading automatically:

```
echo 'packadd friendly' > ~/.vimrc.minimal
echo 'set packpath=$VIMRUNTIME' >> ~/.vimrc.minimal
```

Then configure git to use Vim as editor, initialised with this minimal vimrc:

```
git config --global core.editor 'vim -u ~/.vimrc.minimal'
```

**Can I use this with other plugin managers?**

Yes, but load friendly.vim before other plugins, and your own vimrc settings.

For example, this should work with [vim-plug](https://github.com/junegunn/vim-plug):

```vim
call plug#begin()
Plug 'mmrwoods/vim-friendly'
call plug#end()
runtime! plugin/friendly.vim
```

And this should work with [pathogen.vim](https://github.com/tpope/vim-pathogen):

```vim
execute pathogen#infect()
runtime! plugin/friendly.vim
```

## Caveats

This is a work in progress. If found to be useful, it will change, and break.

## References

Everything here is copied from somewhere else, mostly these places:

* https://github.com/tpope/vim-sensible
* https://neovim.io/doc/user/vim_diff.html
* https://github.com/neovim/neovim/issues/2676
* https://github.com/mmrwoods/dotfiles/blob/main/vim/vimrc
* https://github.com/thoughtbot/dotfiles/blob/main/vimrc
* https://github.com/garybernhardt/dotfiles/blob/main/.vimrc
* https://github.com/vim/vim/blob/master/runtime/defaults.vim
