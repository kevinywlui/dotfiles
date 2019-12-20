set termguicolors
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'chriskempson/base16-vim'

Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch' 

Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf.vim'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'vim-scripts/google.vim'

Plug 'wakatime/vim-wakatime'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:plug_url_format='https://git::@github.com/%s.git'
Plug 'kevinywlui/vim-snippets', { 'branch': 'develop' }
Plug 'SirVer/ultisnips'

call plug#end()

filetype plugin indent on
syntax on

" set encoding
set encoding=utf-8

" no backup or swp files
set nobackup
set noswapfile

" plus register is used by system
set clipboard=unnamedplus

" always at least 5 lines at the bottom
set scrolloff=5

" needed for some plugins
set laststatus=2

" show numbers on the left
set number

" allow mouse interactions
set mouse=a

" highlight matching delimiter
set showmatch

" ignore case unless a capital is given
set ignorecase
set smartcase

" persistent undos
set undofile
set undodir=~/.vimtmp/undo
silent !mkdir -p ~/.vimtmp/undo

" always use file endings
set fileformat=unix

" autoindent
set autoindent

" tabs become spaces
set expandtab

" Tabs consistent with Python specs
set softtabstop=4
set shiftwidth=4
set textwidth=79

" no redraws while performing macros
set lazyredraw

" use base16 to determine colorscheme
if filereadable(expand('~/.vimrc_background'))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Shorter wait before writing to swap
set updatetime=300

" always show signcolumns
set signcolumn=yes


runtime! conf/*.vim
