""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim user interface
""""""""""""""""""""""""""""""""""""""""""""""""""
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
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

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

"" Vundle
" http://vim-users.jp/2011/04/hack215/
filetype off
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()
" plugin
Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
"Bundle 'Shougo/vimshell'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimproc'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-template'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'tyru/open-browser.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
"Bundle 'taglist.vim'
"Bundle 'eregex.vim'
"Bundle 't9md/vim-textmanip'
"Bundle 'Conque-Shell'
Bundle 'neco-look'
Bundle 'pythoncomplete'
"Bundle 'Raimondi/delimitMate'
Bundle 'majutsushi/tagbar'
" not work
"Bundle 'PySmell'
"Bundle 'mrtazz/simplenote.vim'
" colorscheme
"Bundle 'desert.vim'
Bundle 'Wombat'
filetype plugin on

"" unite.vim
" https://github.com/Shougo/unite.vim/blob/master/doc/unite.jax
" http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin
" http://d.hatena.ne.jp/ruedap/20110117/vim_unite_plugin_1_week
" start insert mode
let g:unite_enable_start_insert=1
nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> <leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <leader>um :<C-u>Unite file_mru<CR>
nnoremap <silent> <leader>uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file/new<CR>
" Unite and vim-ref
" :Unite ref/(source-name)

let g:neocomplcache_lock_imninset = 1
" http://vim-users.jp/tag/neocomplcache/
"" neocomplcache
let g:neocomplcache_enable_at_startup = 1
" User startcase
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion
let g:necomplcache_enable_camel_case_completion = 1
" Use underbar completion
let g:neocomplcache_enable_underbar_completion = 1
" Define dictionary
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME. '/.vimshell_hist',
"    \ }
"
" Plugin key-mappings
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)
nnoremap <silent><buffer><expr> <C-k> unite#do_action('preview')
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
" <CR>: close popup and save indent
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" <C-h>: close popup and delete backword char
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#smart_close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd Filetype python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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
let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"" VimShell
" key mappings
"nnoremap <leader>vt :VimShellTab<CR>
"nnoremap <leader>vv :VimShell<CR>
"nnoremap <leader>vp :VimShellPop<CR>
"nnoremap <leader>vi :VimShellInteractive ipython<CR>
" Initialize execute file list
"let g:vimshell_execute_file_list = {}
" error occured
"call vimshell#set_execute_file('text,vim,c,h,cpp,d,xml,java,py', 'vim')
"let g:vimshell_execute_file_list['rb'] = 'ruby'
"let g:vimshell_execute_file_list['pl'] = 'perl'
"let g:vimshell_execute_file_list['py'] = 'python'
"call vimshell#set_execute_file('html,xhtml', 'gexe firefox')
" settings
"let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_max_command_history = 10000
"let g:vimshell_enable_smart_case = 1
"if has('win32') || has('win64')
"    " Display user name on Windows
"    let g:vimshell_prompt = $USERNAME."% "
"else
"    " Display user name on Linux.
"    let g:vimshell_prompt = $USER."% "
"    "call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe gqview')
"    "call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
"    let g:vimshell_execute_file_list['zip'] = 'zipinfo'
"    "call vimshell#set_execute_file('tgz,gz', 'gzcat')
"    "call vimshell#set_execute_file('tbz,bz2', 'bzcat')
"endif

"" gist-vim
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

"autocmd FileType vimshell
"            \ call vimshell#altercmd#define('g', 'git')
"            \| call vimshell#altercmd#define('i', 'iexe')
"            \| call vimshell#altercmd#define('l', 'll')
"            \| call vimshell#altercmd#define('ll', 'ls -l')
"            \| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')
"
"            function! g:my_chpwd(args, context)
"                call vimshell#execute('ls')
"            endfunction
"
"            autocmd FileType int-* call s:interactive_settings()
"            function! s:interactive_settings()
"            endfunction
"
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
"" delimitMate
"autocmd FileType html,htmldjango,jinjahtml,mako let b:closetab_html_style=1

"" simplete.vim
let g:SimplenoteUsername = "metamosco@gmail.com"
let g:SimplenotePassword = "uTLftTPtnu"
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
set shiftwidth=4
set tabstop=4
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
set encoding=utf-8
"utf-8以外の文字コードも読み込む
set fileencodings=utf-8,euc-jp,cp932
set fileformat=unix

""""""""""""""""""""""""""""""""""""""""""""""""""
" key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vim-users.jp/2010/11/hack181/
" Open junk file. "{{{
"command! -nargs=0 JunkFile call s:open_junk_file()
"" s: cannote be accessed from outside of the scripts, thus are local to the script.
"function! s:open_junk_file()
"    " l: local-variable
"    let l:junk_dir = $HOME . '/.vim_junk' . strftime('/%Y/%m')
"    if !isdirectory(l:junk_dir)
"        call mkdir(l:junk_dir, 'p')
"    endif
"
"    let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
"    if l:filename != ''
"        execute 'edit ' . l:filename
"    endif
"endfunction"}}}
"" keymap
"nnoremap <leader>j :JunkFile<CR>

" Open memo file "{{{
command! -nargs=0 MemoFile call s:open_memo_file()
function! s:open_memo_file()
    let l:memo_dir = $HOME . '/memos'
    if !isdirectory(l:memo_dir)
        call mkdir(l:memo_dir)
    endif

    let l:filename = input('Memo File Name: ', l:memo_dir . ('/'))
    if l:filename != ''
        execute 'edit ' . l:filename
    endif
endfunction "}}}
" keymap
nnoremap <leader>m :<C-u>MemoFile<CR>

" Store messages "{{{
" http://vim-users.jp/2011/06/hack220/
"command! -nargs=0 StoreCommand call s:store_command()
"function! s:store_command()
"    let l:fname = '/tmp' . strftime('/%H%M%S')
"    if l:fname != ''
"        "execute 'edit ' . l:fname
"        execute 'redir > ' . l:fname
"        execute 'silent ' . l:fname
"        execute 'mes'
"        execute 'redir END'
"        execute 'edit ' . l:fname
"        " editした後にdeleteしたいのだけと
"        call delete(l:fname)
"    endif
"endfunction"}}}

" http://vim-users.jp/2011/02/hack203/
" show all mappings
command!
            \ -nargs=* -complete=mapping
            \ AllMaps
            \ map <args> | map! <args> | lmap <args>

" Usage
" :AllMaps -> show all mappings
" :AllMap <buffer> -> show mappings defined in current buffer
" :verbose AllMaps <buffer> same above, but include script file names

command! -nargs=0 GetCWD call s:get_cwd()
function! s:get_cwd()
    let l:cwd = getcwd()
    "cd l:cwd
    echo l:cwd
endfunction

nnoremap <leader>cd :GetCWD<CR>

" toggle wrap
" wrap! -> toggle wrap
" wrap? -> confirm current wrap mode
nnoremap <Space>ow
\   :<C-u>setlocal wrap!
\   \|    setlocal wrap?<CR>

nnoremap <Space>m :<C-u>marks<CR>
nnoremap <Space>r :<C-u>registers<CR>
nnoremap <Space>l :<C-u>ls<CR>
nnoremap <Space>cd :<C-u>cd %:h<CR>
nnoremap <leader>ls :<C-u>!ls -F<CR>

" template
"autocmd! BufNewFile *.py silent! 0r $HOME/.vim/skel/python.txt:e
"autocmd! BufNewFile *.sh silent! 0r $HOME/.vim/skel/shell.txt:e

" remove trailing space
autocmd! BufWritePre * :%s/\s\+$//ge

" wrap
"setlocal textwidth=80

