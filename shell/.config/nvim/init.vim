set termguicolors
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'chriskempson/base16-vim'

Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf.vim'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

Plug 'wakatime/vim-wakatime'

let g:plug_url_format='https://git::@github.com/%s.git'
Plug 'kevinywlui/vim-snippets', { 'branch': 'develop' }
Plug 'SirVer/ultisnips'

Plug 'dense-analysis/ale'



call plug#end()

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
set hidden
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


runtime! conf/*.vim
