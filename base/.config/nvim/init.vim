call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'wakatime/vim-wakatime'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'w0rp/ale'
call plug#end()

" airline/tagbar
let g:airline#extensions#tagbar#flags = 'f'

" ale
let g:ale_linters = {
            \   'python': ['pycodestyle'],
            \   'sh': ['shfmt'],
            \}
let g:ale_fixers = {
            \   'python': ['yapf'],
            \}

let g:ale_tex_chktex_options = "-n 3 13"

" vimwiki
" let g:vimwiki_list = [{'path': '~/vimwiki/',
"             \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_hl_headers = 1
" let g:vimwiki_url_maxsave = 0

" vimtex
let g:tex_flavor = "latex"
let g:vim_markdown_folding_disabled = 1
let g:vimtex_view_method = 'zathura'
let g:tex_conceal = ""
let g:vimtex_quickfix_mode = 0
"

let g:vimtex_quickfix_latexlog = {
            \ 'default' : 1,
            \ 'general' : 1,
            \ 'references' : 1,
            \ 'overfull' : 1,
            \ 'underfull' : 1,
            \ 'font' : 1,
            \ 'packages' : {
            \   'default' : 1,
            \   'natbib' : 1,
            \   'biblatex' : 1,
            \   'babel' : 1,
            \   'hyperref' : 0,
            \   'scrreprt' : 1,
            \   'fixltx2e' : 1,
            \   'titlesec' : 1,
            \ },
            \}

filetype plugin indent on
set conceallevel=0
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
autocmd bufreadpre *.py setlocal textwidth=0
" set textwidth=79
set expandtab
set autoindent
set fileformat=unix
set nojoinspaces

set background=dark
colorscheme gruvbox

" Mappings
cmap w!! %!sudo tee > /dev/null %
map <SPACE> :w <ENTER>
map <F2> :noh <ENTER>
map <F4> :TagbarToggle <ENTER>
