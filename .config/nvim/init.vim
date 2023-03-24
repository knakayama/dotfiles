syntax on
let mapleader=" "
set nocompatible
set showmatch              
set ignorecase
set number
set clipboard+=unnamedplus
nnoremap <silent> <leader>w :w <CR>

if has('ide')
  set ideajoin
  set ideastatusicon=gray
  set idearefactormode=keep
endif
