call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'majutsushi/tagbar'
Plug 'wakatime/vim-wakatime'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }
Plug 'w0rp/ale'
Plug 'junegunn/fzf.vim'
Plug 'Vimjas/vim-python-pep8-indent'
let g:plug_url_format='https://git::@github.com/%s.git'
Plug 'kevinywlui/vim-snippets'
call plug#end()

" Mappings
cmap w!! %!sudo tee > /dev/null %
map <SPACE> :w <ENTER>
nmap <silent> <leader>h :History<CR>
nmap <silent> <leader>t :TagbarToggle<CR>
nmap <silent> <leader>f :ALEFix<CR>
nmap <silent> <leader>a :let g:ale_fix_on_save = 1<CR>

nmap <silent> <C-j> :cn<CR>
nmap <silent> <C-k> :cp<CR>

setlocal spell
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" airline/tagbar
let g:airline#extensions#tagbar#flags = 'f'

" ale
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
" let g:vimtex_compiler_method = 'latexrun'
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
set fileformat=unix
set nojoinspaces 
set background=dark
colorscheme gruvbox
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set autoindent 
set fileformat=unix
au Filetype python
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |

au Filetype yaml
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2
