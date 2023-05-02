# friendly.vim

Friendly defaults for Vim, if you are new to Vim, this is a good place to start.

Inspired by Tim Pope's [sensible.vim](https://github.com/tpope/vim-sensible),
but unconstrained by any ambition to be universal set of defaults, this plugin
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

Use your favourite package manager, or Vim's built-in package support:

```
mkdir -p ~/.vim/pack/mmrwoods/start
cd ~/.vim/pack/mmrwoods/start
git clone https://github.com/mmrwoods/vim-friendly.git friendly
```

If you like to get loco, you could use this as your initial vimrc:

```
git clone https://github.com/mmrwoods/vim-friendly.git
cp vim-friendly/plugin/friendly.vim ~/.vimrc
rm -rf vim-friendly
```

If you like to get really loco, you could use this for git only:

```
git clone https://github.com/mmrwoods/vim-friendly.git
cp vim-friendly/plugin/friendly.vim ~/.vimrc.minimal
git config --global core.editor "vim -u ~/.vimrc.minimal"
```

## Customisation

If installed as a plugin, add this to your vimrc and put your overrides below:

```
runtime! plugin/friendly.vim
```

Alternatively, install as an optional package and use `packadd friendly` in your
vimrc. See `:help packages`.

## Caveats

This is a work in progress, and if found to be useful, it will change.
