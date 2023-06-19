# friendly.vim

Friendly defaults for Vim, if you are new to Vim, this is a good place to start.

Inspired by Tim Pope's [sensible.vim](https://github.com/tpope/vim-sensible),
but unconstrained by any ambition to be a universal set of defaults, this plugin
overrides some of Vim's default settings and adds a few other minor tweaks to
make Vim less terrifying.

Most settings have been extracted from my own vimrc, many of which are copied
from other people's vimrcs, tips from Vim's documentation, Vim's built-in
defaults.vim, Tim Pope's sensible.vim and also from Neovim's defaults.

This is intended as a baseline Vim configuration and everything should be easy
to override from your own vimrc. If you find something is not easy to override,
please submit an issue (or even better, open a pull request).

## Features

* Friendly, but not universally applicable, default settings for writing code.
* Disables some default mappings which new users find confusing (e.g. Q and q).
* Adds default mappings from Neovim, sensible.vim and Vim's own defaults.vim.
* Adds some convenience mappings for new users (e.g. Tab/S-Tab to shift lines).
* Sets the default color scheme to slate, hopefully more appealing to new users.
* Enables spell checking for some files by default (e.g. gitcommit, markdown)
* Enables system clipboard integration (and X11 primary selection if available).
* Adds simple tab completion in insert mode, including relative path completion.
* Handles existing swap files where possible (swap file warnings are confusing).
* Opens diff in vertical split when writing commits with `git commit --verbose`.

Changing how Vim handles git commits might seem an odd thing to include in what
should be a baseline Vim configuration, but for many new users, writing a commit
message is their first real interaction with Vim, and I want that to be a
positive experience, encouraging people to use Vim (and write good commits).

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

If you don't have a vimrc, just create one that loads friendly.vim:

```
echo 'packadd friendly' >> ~/.vimrc
```

## Customisation

Make any changes you like after `packadd friendly` in your vimrc. Settings can
just be overridden, mappings can undone using `unmap` and friends, but autocmds
are a little tricky as you need to reset the autocmd group (at least for now).

```vim
packadd friendly

" always fix missing EOL at end of file when saving
set fixeol

" undo q <nop> mapping, allow recording of macros
unmap q

" stop automatically clearing search highlighting
augroup friendly_hlsearch | au! | augroup END
```

## FAQs

**I don't like the color scheme, can I change it?**

Of course, I just chose a default color scheme that is included in Vim versions
8 and 9 and resembles the defaults in Sublime and Visual Studio Code, but you can
change the color scheme using the `colorscheme` command.

Open Vim and type `:colorscheme ` followed by Tab to see available color schemes
as completion options. Try them out to see which one you like, and then add it to
your vimrc to make this your new default, e.g.

```vim
packadd friendly

colorscheme habamax
```

By default you can only choose from color schemes included with Vim, but there
are hundreds, if not thousands, of other color schemes available as plugins.

**Does this support [EditorConfig](https://editorconfig.org/)?**

No, but Neovim natively supports EditorConfig and there is also an "official"
EditorConfig [plugin](https://github.com/editorconfig/editorconfig-vim) for Vim.

If you install the EditorConfig plugin for Vim, you might want to add the
following lines to your vimrc:

```vim
" Don't force hard wrap at max line length
let g:EditorConfig_preserve_formatoptions = 1

" Only highlight when line exceeds max length
let g:EditorConfig_max_line_indicator = "fillexceeding"
```

**Why does this default to a 2-space indent?**

Because 2-space and 4-space indent seem the most popular indenting styles, and
defaulting to 2 rather than 4 spaces makes the default usable for most people.
If you don't like this, you can change it in your vimrc:

```vim
set shiftwidth=4
```

Or you could just install [sleuth.vim](https://github.com/tpope/vim-sleuth) and
forget about it. Sleuth.vim also supports EditorConfig files, but doesn't trim
trailing whitespace. For a minimalist Vim configuration, friendly.vim and
sleuth.vim make a great combination.

**Can I use this as a minimal vimrc for git commits?**

Yes, create a separate vimrc that adds friendly.vim and disables other plugins:

```
echo 'packadd friendly' > ~/.vimrc.minimal
echo 'set noloadplugins' >> ~/.vimrc.minimal
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

**Why do I have to explicitly load friendly.vim?**

Strictly speaking, you don't, but this is far from a universally accepted set of
defaults, and you may well want to override/unset some of them in your vimrc
(Vim plugins are normally loaded after your vimrc). Some settings may also have
unintended side-effects if they are not applied first, so loading friendly.vim
first avoids surprises.

## Caveats

This is a work in progress. If found to be useful, it will change, and break.

## References

Almost everything here is copied from somewhere else, mostly these places:

* https://github.com/tpope/vim-sensible
* https://neovim.io/doc/user/vim_diff.html
* https://github.com/neovim/neovim/issues/2676,
  https://github.com/neovim/neovim/issues/6289,
  https://github.com/neovim/neovim/issues/19354
* https://github.com/mmrwoods/dotfiles/blob/main/vim/vimrc
* https://github.com/thoughtbot/dotfiles/blob/main/vimrc
* https://github.com/garybernhardt/dotfiles/blob/main/.vimrc
* https://github.com/vim/vim/blob/master/runtime/defaults.vim

## Licence

Distributed under the same terms as Vim itself. See `:help license`.
