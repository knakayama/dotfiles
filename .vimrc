""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim user interface
""""""""""""""""""""""""""""""""""""""""""""""""""

" be improved
set nocompatible
"turn on wild menu
set wildmenu

"always show current position
set ruler

"ignore case when searching
set ignorecase

"incremental search
set incsearch

"set magic on, for regular expressions
" if :set nomagic, * mark matches word * and \* means 繰り返し
set magic

"show matching brackets when text indicator is over them
set showmatch

"no sound on errors
set noerrorbells
"set novisualbell
"set t_vb=

"share clipboard with other applications
" http://vim-users.jp/2010/02/hack126/
" autoselect: visual modeでも同じ挙動にする場合
" "*Y copy line to clipboard
" "*p paste from clipboard
set clipboard=unnamed,autoselect

"show status line
set laststatus=2

"commandline height
set cmdheight=1

"show commandline
set showcmd

"show filename on titlebar
set title

"consider case if the search pattern contains uppercase
set smartcase

set modeline

" show line number
set number

" Vim interprets numerals with a leading zero to be in octal notation rather than in decimal.
" Above will cause Vim to treat all numerals as decimal, regardless of whether they are padded with zeros.
set nrformats=

" line space
"set linespace=4

" hilighting cursor horizontally
"set cursorline
" hilighting cursor vertically
"set cursorcolumn

"hilight cursor line
"autocmd WinEnter * setlocal cursorline
"autocmd WinLeave * setlocal nocursorline
"set cursorline

" map leader
let mapleader = ","
let g:mapleader = ","

" cause files to be automatically saved when you switch buffers
" and external commands
" set autowrite

" automatically save when quitting vim
" set autowriteall

"http://blog.remora.cx/2011/04/show-invisible-spaces-in-vim.html
" display unprintable character
set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set listchars=trail:_

""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
""""""""""""""""""""""""""""""""""""""""""""""""""
"turn backup off
set nobackup
set noswapfile
set nowb
"define backup dir
"set backupdir=$HOME/vimbackup
"set directory=$HOME/vimbackup

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin section
""""""""""""""""""""""""""""""""""""""""""""""""""

" NeoBundle
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" plugin list
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \   'mac' : 'make -f make_mac.mak',
        \   'unix' : 'make -f make_unix.mak',
        \   },
        \ }
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-template'
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-surround'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Wombat'
NeoBundle 'glidenote/serverspec-snippets'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'kannokanno/previm'
NeoBundle 'rodjek/vim-puppet'
NeoBundle 'godlygeek/tabular'

" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"" unite.vim
" https://github.com/Shougo/unite.vim/blob/master/doc/unite.jax
" http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin
" http://d.hatena.ne.jp/ruedap/20110117/vim_unite_plugin_1_week
" start insert mode
let g:unite_enable_start_insert=1
nnoremap [unite] <Nop>
nmap <leader>u [unite]
nnoremap [unite]b :<C-u>Unite buffer<CR>
nnoremap [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap [unite]m :<C-u>Unite file_mru<CR>
nnoremap [unite]u :<C-u>Unite buffer file_mru<CR>
nnoremap [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file/new<CR>
" Unite and vim-ref
" :Unite ref/(source-name)
nnoremap <silent><buffer><expr> <C-k> unite#do_action('preview')

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"" neosnippets.vim
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" setting example
let g:neosnippet#snippets_directory = [
      \'~/.vim/bundle/neosnippet-snippets',
      \'~/.vim/bundle/serverspec-snippets',
      \]

"" vimfiler
" use vimfiler as default filer
let g:vimfiler_as_default_explorer = 1

"" taglist
"nnoremap T :TlistToggle<CR>

"" tagbar
" help F1
let g:tagbar_left=1
" If you set this option the cursor will move to the Tagbar window
" when it is opened.
let g:tagbar_autofocus=1
" Omitting the short help and the blank lines in between top-level scopes
" in order to save screen real estate.
let g:tagbar_compact=1
"let g:tagbar_usearrows=1
nnoremap <leader>T :TagbarToggle<CR>

"" syntastic
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"" gist-vim
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

"" open-browser
" If it looks like URI, open URI under the cursor
" Otherwise, search word under the cursor
nmap <leader>w <Plug>(openbrowser-smart-search)
vmap <leader>w <Plug>(openbroswer-smart-search)

"" quickrun
" horizontal split
let g:quickrun_config={'*': {'split': ''}}
let g:quickrun_config['markdown'] = {
    \ 'type': 'markdown/markdown_py',
    \ 'outputter': 'browser',
    \ 'command': 'markdown_py',
    \ 'cmdopt': '-e UTF8',
    \ }

" http://tech.toshiya240.com/articles/2014/06/matchit-vim/
source $VIMRUNTIME/macros/matchit.vim
augroup matchit
  autocmd!
  autocmd FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
augroup END

" vim-ansible-yaml
let g:ansible_options = {'ignore_blank_lines': 0}

" previm
"2. Attempt open browser with openbrowser#open()
let g:previm_open_cmd = 'open -a Firefox'
"let g:previm_enable_realtime = 1
noremap <leader>m :PrevimOpen<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" colors , fonts and gui settings
""""""""""""""""""""""""""""""""""""""""""""""""""
"enable syntax hl
syntax enable
syntax on

" :color -> confirm used color
" must specify colorscheme after loading Vundle
" https://github.com/gmarik/vundle/issues/14
if has('gui_running')
    colorscheme wombat
" http://wildlifesanctuary.blog38.fc2.com/blog-entry-180.html
" When colors_name is wombat, change visual mode color
    if g:colors_name ==? 'wombat'
        hi Visual gui=none guifg=khaki guibg=olivedrab
    endif
endif

" Fonts
" font_name:font_size(not windows platform)
if has('gui_running')
    set guifont=Ricty\ bold\ 15
endif

" GUI settings
" Do not use GUI settings
if has('gui_running')
    set guioptions=
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Python section
""""""""""""""""""""""""""""""""""""""""""""""""""
" fast editing
nnoremap <leader>ph :!python % -h<CR>
nnoremap <leader>pp :!python %<CR>
nnoremap <leader>pf :<C-u>!flake8 %<CR>
nnoremap <leader>pfv :<C-u>!flake8 --show-pep8 %<CR>
nnoremap <leader>pt :call setline(".", "# coding: utf-8")<CR>
"nnoremap <leader>ph :QuickRun python -args "-h"<CR>
"nnoremap <leader>pp :QuickRun python<CR>
" これだとsourceがbash commandだと解釈されてしまう〜
"nnoremap <leader>vs :QuickRun vim
"nnoremap <leader>vs :source %<CR>

"command! -nargs=0 QuickPython call s:quick_run_python()
"function! s:quick_run_python()
"    let l:arg_name = input('Args: ')
"    :QuickRun python -command 'test'
"endfunction
"nnoremap <leader>pr :QuickPython<CR>

" http://d.hatena.ne.jp/natsumesouxx/20101229/1293609386
" http://www.vim.org/scripts/script.php?script_id=2421
" for pysmell completion
"autocmd FileType python setlocal omnifunc=pysmell#Complete
" for pythoncomplete completion
autocmd! FileType python set omnifunc=pythoncomplete#Complete
"" execute file on editing
"function! s:Exec()
"    exe "!" . &ft . " %"
"endfunction
"command! Exec call <SID>Exec()
""map <silent><C-P> :call <SID>Exec()<CR>
""nnoremap <silent><C-p> :<C-u>execute'!'&l:filetype'&'<Return>
"nnoremap <silent> <C-p> :<C-u>execute '!' &l:filetype '%'<Return>

""""""""""""""""""""""""""""""""""""""""""""""""""
" General, keymap
""""""""""""""""""""""""""""""""""""""""""""""""""
"sets how many lines of history Vim has to remenber
set history=300

"enable filetype plugin
filetype plugin on
filetype indent on

"set to auto read when a file is changed from the outside
set autoread

" fast tabnew
nnoremap <silent><leader>t :tabnew<CR>

"fast editing .vimrc
nnoremap <silent><leader>et :tabnew $MYVIMRC<CR>
nnoremap <silent><leader>en :new $MYVIMRC<CR>
nnoremap <leader>es :source $MYVIMRC<CR>

"When .vimrc  was edited, reload it
"autocmd! bufwritepost vimrc source $MYVIMRC

" ack integration with vim
"set grepprg=ack\ -a

""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set lbr
set tw=500

"auto indent
set autoindent " ai

"smart indent
set smartindent " si

"no wrap lines
"set nowrap

" 折り返し検索を有効にする
"set wrapscan


""""""""""""""""""""""""""""""""""""""""""""""""""
" backspace problem
""""""""""""""""""""""""""""""""""""""""""""""""""
noremap  
noremap!  
set backspace=2

""""""""""""""""""""""""""""""""""""""""""""""""""
" encoding
""""""""""""""""""""""""""""""""""""""""""""""""""
"set encoding=euc-jp
"utf-8以外の文字コードも読み込む
"set fileencodings=utf-8,euc-jp,cp932
"set fileformat=unix

""""""""""""""""""""""""""""""""""""""""""""""""""
" key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <Space>m :<C-u>marks<CR>
nnoremap <Space>r :<C-u>registers<CR>
nnoremap <Space>l :<C-u>ls<CR>
nnoremap <Space>cd :<C-u>cd %:h<CR>
nnoremap <leader>ls :<C-u>!ls -F<CR>

" Tip 34: Recall Commands from History
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

""""""""""""""""""""""""""""""""""""""""""""""""""
" auto
""""""""""""""""""""""""""""""""""""""""""""""""""

" remove trailing space
function! RTrim()
    let s:cursor = getpos(".")
    if &filetype != "markdown"
        :%s/\s\+$//ge
    endif
    :call setpos(".", s:cursor)
endfunction

autocmd! BufWritePre * :call RTrim()

" set filetype to markdown when opening .md file.
" why not default? default syntax is modula2...
autocmd BufNewFile,BufRead,BufReadPre *.md set filetype=markdown

" coffee
autocmd BufNewFile,BufRead,BufReadPre *.coffee set filetype=coffee

" ansible-yaml
autocmd BufNewFile,BufRead,BufReadPre *.yml set filetype=ansible

