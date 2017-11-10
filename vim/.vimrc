" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

" Number madness
"
set number

function! NumberToggle()
  if(&relativenumber == 1)
    set rnu!
  else
    set rnu
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" End numbers 

" Tabs
set expandtab ts=4 sw=4 ai
set softtabstop=4

" Swap directory
set directory=$HOME/.vim/swapdir//

set textwidth=80

" TeX
set grepprg=grep\ -nH\ $*
let g:tex_flavor="latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
filetype plugin on
filetype indent on

" Arrow keys
" noremap  <Up> ""
" noremap! <Up> <Esc>
" noremap  <Down> ""
" noremap! <Down> <Esc>
" noremap  <Left> ""
" noremap! <Left> <Esc>
" noremap  <Right> ""
" noremap! <Right> <Esc>

" Mouse
set mouse=

" Pluggins
" call plug#begin('~/.vim/plugin')

" Plug 'lervag/vimtex' " For LaTeX files
" Plug 'sirtaj/vim-openscad' " Syntax highlighting for openscad

" call plug#end()

" Gui font
set guifont=Source\ Code\ Pro\ for\ Powerline\ 10

" Status line
let g:powerline_pycmd="py3"
set ls=2

" Do what I mean dammit
command DWIM w !sudo tee % >/dev/null
