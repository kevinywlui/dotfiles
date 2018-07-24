call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'w0rp/ale'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
call plug#end()
let g:tex_flavor = "latex"
let g:vim_markdown_folding_disabled = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
let g:ale_linters = {
\   'tex': [
\   ],
\}
" \       'chktex',

let g:ale_fixers = {
\   'python': [
\       'yapf',
\       'remove_trailing_lines',
\       'trim_whitespace' 
\       ],
\   'latex': [
\       'chktex',
\    ],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
" let g:ale_tex_chktex_options = '-I -n3 -n24 -n8 -n18 -n13'

filetype plugin indent on
set autoread
set autowrite
set nobackup
set encoding=utf-8
set noswapfile
set nrformats=
set clipboard=unnamedplus
set timeout timeoutlen=1000 ttimeoutlen=100
set backspace=eol,indent,start
set scrolloff=5
set showmode
set showcmd
set number
set laststatus=2
syntax on
set mouse=a
set showmatch
set wrap
set ignorecase
set smartcase
set incsearch
set splitbelow
set splitright
set hlsearch
set undofile
set undodir=~/.vimtmp/undo
silent !mkdir -p ~/.vimtmp/undo
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

set background=dark
colorscheme solarized

" Mappings
cmap w!! %!sudo tee > /dev/null %
map <SPACE> :w <ENTER>
map <F2> :noh <ENTER>
map <F3> :!latexmk -pdf % <ENTER>
map <F4> :TagbarToggle <ENTER>
map <F5> :ALEFix <ENTER>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:tex_conceal = ""
