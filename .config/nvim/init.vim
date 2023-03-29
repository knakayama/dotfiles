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
  "set ideastatusicon=gray
  set idearefactormode=keep

  let mapleader = " "
  nmap <c-p> <Action>(PreviousTab)
  nmap <c-n> <Action>(NextTab)
  nmap <leader>e :action ShowErrorDescription<CR>
  nnoremap <leader>r :source ~/.ideavimrc<CR>
  nnoremap <leader>, :edit ~/.config/nvim/init.vim<CR>
endif
