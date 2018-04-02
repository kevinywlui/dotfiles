call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'w0rp/ale'
Plug 'kevinywlui/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
" Plug 'wakatime/vim-wakatime'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
call plug#end()

let g:ale_fixers = {
\   'python': ['yapf'],
\}
let g:ale_lint_on_text_changed = 'never'
" let g:ale_fix_on_save = 1

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
map <F4> :ALEFix <ENTER>
let g:tex_conceal = ""
