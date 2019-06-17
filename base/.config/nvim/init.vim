set termguicolors
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'sainnhe/vim-color-forest-night'
Plug 'morhetz/gruvbox'

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'

Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'wakatime/vim-wakatime'



Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

Plug 'scrooloose/nerdtree'


let g:plug_url_format='https://git::@github.com/%s.git'
Plug 'kevinywlui/vim-snippets'
Plug 'SirVer/ultisnips'
call plug#end()


nnoremap <C-p> :Files<Cr>

set background=dark
colorscheme forest-night
let g:lightline = {}
let g:lightline.colorscheme = 'forest_night'




let g:indentLine_faster = 1

cmap w!! %!sudo tee > /dev/null %
map <SPACE> :w <ENTER>
nmap <silent> <leader>h :History<CR>
nmap <silent> <leader>o :FZF<CR>
nmap <silent> <leader>t :TagbarToggle<CR>
nmap <silent> <leader>f :ALEFix<CR>
nmap <silent> <leader>a :let g:ale_fix_on_save = 1<CR>

nnoremap <leader><space> :nohlsearch<CR>
nmap <silent> <C-j> :cn<CR>
nmap <silent> <C-k> :cp<CR>
map <C-n> :NERDTreeToggle<CR>

setlocal spell
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

let g:ale_linters = {
            \   'python': ['flake8'],
            \   'sh': ['shfmt'],
            \}
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'python': ['yapf'],
            \}

let g:ale_tex_chktex_options = "-n 3 13"
let g:ale_python_pycodestyle_options = "--ignore='E741'"

let g:vimwiki_hl_headers = 1
let g:vimwiki_conceallevel = 0

let g:tex_flavor = "latex"
let g:vimtex_view_method = 'zathura'
let g:tex_conceal = ""
let g:vimtex_quickfix_mode = 0
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

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

filetype plugin indent on
set autoread
set autowrite
set nobackup
set encoding=utf-8
set noswapfile
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
set hlsearch
set undofile
set undodir=~/.vimtmp/undo
silent !mkdir -p ~/.vimtmp/undo
set fileformat=unix
set nojoinspaces 
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set autoindent 
set fileformat=unix
set lazyredraw
