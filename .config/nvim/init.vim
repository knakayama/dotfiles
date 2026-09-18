syntax on
colorscheme sorbet
let mapleader=" "
set nocompatible
set showmatch              
set ignorecase
set number
set clipboard+=unnamedplus
nnoremap <silent> <leader>w :w <CR>

" Always keep a trailing newline at end of file
set fixendofline

" Clean up on save: strip trailing whitespace (keeps cursor position) and
" force a final newline, even if the file lacked one
augroup SaveCleanup
  autocmd!
  autocmd BufWritePre * let s:view = winsaveview() | keeppatterns %s/\s\+$//e | call winrestview(s:view)
  autocmd BufWritePre * setlocal endofline
augroup END

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
  "nmap / <Action>(Find)
  nnoremap <leader>r :source ~/.ideavimrc<CR>
  nnoremap <leader>, :edit ~/.config/nvim/init.vim<CR>
endif

" ===== Native LSP (nvim 0.11+, no plugins) =====
lua << EOF
-- mise-managed servers (ts_ls, pyright) live behind shims; make nvim find them
-- regardless of which directory/node version is active when nvim launches.
vim.env.PATH = vim.fn.expand('~/.local/share/mise/shims') .. ':' .. vim.env.PATH

-- Server definitions: cmd + which filetypes trigger them + how to find the project root
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json', '.git' },
})

vim.lsp.config('terraformls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
})

vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
})

vim.lsp.enable({ 'gopls', 'ts_ls', 'pyright', 'terraformls', 'marksman' })

-- Runs each time a server attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- native autocompletion as you type (0.11+)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)         -- go to definition
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
  end,
})

vim.diagnostic.config({ virtual_text = true, severity_sort = true })
EOF
