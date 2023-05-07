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

  "" Mappings
  let mapleader = " "
  nmap 0 ^
  nmap <leader>q <Action>(CloseContent)
  nmap <leader>Q <Action>(CloseAllEditors)
  " 0 -> first non-blank character
  nmap <C-p> <Action>(PreviousTab)
  nmap <C-n> <Action>(NextTab)
  nmap <leader>h <Action>(ShowErrorDescription)
  nmap [h <Action>(GotoPreviousError)
  nmap ]h <Action>(GotoNextError)
  nmap <leader>ff <Action>(GotoFile)
  nmap <leader>fg <Action>(FindInPath)
  nmap <leader>fm <Action>(MainMenu)
  nmap <leader>fr <Action>(RecentFiles)
  nmap <leader>fp <Action>(ManageRecentProjects)
  nmap / <Action>(Find)
  nnoremap <leader>r :source ~/.ideavimrc<CR>
  nnoremap <leader>, :edit ~/.config/nvim/init.vim<CR>
endif
