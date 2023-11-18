# friendly.vim

Friendly defaults for Vim, if you are new to Vim, or even Neovim, this is a good
place to start. If you just need a basic Vim configuration for writing git
commits and quickly editing code from your terminal, this is made for you.

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
* Disables or remaps some commands which new users find confusing (e.g. q:).
* Adds default mappings from Neovim, sensible.vim and Vim's own defaults.vim.
* Adds some convenience mappings for new users (e.g. Tab/S-Tab to shift lines).
* Sets the default color scheme to slate, hopefully more appealing to new users.
* Enables spell checking for some files by default (e.g. gitcommit, markdown).
* Enables system clipboard integration (and X11 primary selection if available).
* Adds simple tab completion in insert mode, including relative path completion.
* Handles existing swap files where possible (swap file warnings are confusing).
* Enhanced editing of git commits, especially when using `git commit --verbose`.

Changing how Vim handles git commits might seem an odd thing to include in what
should be a baseline Vim configuration, but for many new users, writing a commit
message is their first real interaction with Vim, and I want that to be a
positive experience, encouraging people to use Vim (and write good commits).
Friendly.vim improves diff syntax highlighting, highlights long lines, and opens
diffs in a vertical split when using `git commit --verbose`.

## Requirements

Vim 8.1 or later, though some features are only supported by and enabled on
later versions. Some features might require "huge" Vim, which is probably what
you got when you installed Vim. Only tested on Mac and Debian, might work fine
on Windows too. Also known to work on Neovim, but I don't use Neovim regularly.

## Installation

### Vim

Install as an optional plugin using Vim's built-in package support:

```
git clone https://github.com/mmrwoods/vim-friendly.git \
  ~/.vim/pack/mmrwoods/opt/friendly
```

Add add this line to the start of your vimrc (e.g. ~/.vimrc):

```vim
packadd friendly
```

If you don't have a vimrc, just create one that loads friendly.vim:

```
echo 'packadd friendly' >> ~/.vimrc
```

### Neovim

Install as an optional plugin using Vim's built-in package support:

```
git clone https://github.com/mmrwoods/vim-friendly.git \
  ~/.config/nvim/pack/mmrwoods/opt/friendly
```

Add add this line to the start of your vimrc (e.g. ~/.config/nvim/init.vim):

```vim
packadd friendly
```

If you don't have a vimrc, just create one that loads friendly.vim:

```
echo 'packadd friendly' >> ~/.config/nvim/init.vim
```

## Customisation

Make any changes you like after `packadd friendly` in your vimrc. Settings can
just be overridden, mappings can undone using `unmap` and friends, but autocmds
are a little tricky as you need to reset the autocmd group (at least for now).

```vim
packadd friendly

" always fix missing EOL at end of file when saving
set fixeol

" undo Q mapping, I prefer to use this for Ex mode
unmap Q

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

**How can I show whitespace characters, similar to VS Code?**

Enable the `'list'` option in Vim to show unprintable characters. You can do
this directly from an editing session by running `:set list!` to toggle the
option. If you prefer this to be on by default, you can set it in your vimrc:

```vim
set list
```

Which unprintable characters are shown and how they are are rendered is
determined by the `'listchars'` option. Friendly.vim overrides the Vim default
for `'listchars'` to render whitespace similar to VS Code.

**Why is spell checking enabled for some files, and can I disable it?**

The initial use case for this plugin was to make Vim more approachable to people
using it to write commits and edit documentation, so friendly.vim enables spell
check by default for gitcommit, markdown and a few other file types. If you
don't want spell checking to be enabled by default for any file types you can
just disable it in your vimrc:

```vim
set nospell
```

If you just want to disable spellcheck temporarily, you can do this using `:set
spell!` to toggle the option.

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

**Can I use this with other completion plugins, e.g. coc.nvim?**

Yes, you can, though whether it "just works" is dependent on the other plugin.
Friendly.vim adds completion menu aware Tab, Shift-Tab and CR mappings which
move next/previous and accept completion while the menu is visible. These
mappings might just work with your preferred plugin, if not you can override
them as needed in your vimrc.

With [coc.nvim](https://github.com/neoclide/coc.nvim), these mappings should
just work because coc.nvim rewrites existing completion aware mappings to
coc.nvim aware variants (coc.nvim has its own custom completion menu). If the CR
mapping does not just work, that's probably because some other plugin has
wrapped the friendly.vim CR mapping in a custom function before coc.nvim checks
for existing completion menu aware mappings. You can check this by running
`:verbose imap <CR>`, and you can fix it by adding a custom, coc.nvim aware, CR
mapping to your vimrc, e.g.

```vim
inoremap <expr> <CR> exists('*coc#pum#visible') && coc#pum#visible()
  \ ? coc#pum#confirm() : ( pumvisible() ? '<C-y>' : "\<CR>" )
```

With other plugins which have custom functions to navigate the completion menu
and/or accept completions, you'll probably need to override the friendly.vim
mappings in your vimrc. You can do this such that your mappings will trigger the
plugin functions when the plugin is enabled, and otherwise fall back
to friendly.vim style mappings. For example
[asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) has a
custom function to accept a completion, so you could add a CR mapping to your
vimrc to use asyncomplete when enabled, otherwise fall back to standard Vim
completion, e.g.

```vim
inoremap <expr> <CR> pumvisible() ? ( get(b:,"asyncomplete_enable",0)
  \ ? asyncomplete#close_popup() : '<C-y>' ) : "\<CR>"
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
