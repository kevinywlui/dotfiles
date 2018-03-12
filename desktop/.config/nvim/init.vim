call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'w0rp/ale'
Plug 'kevinywlui/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/indentpython.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'wakatime/vim-wakatime'
call plug#end()

let g:ale_fixers = {
\   'python': ['flake8'],
\}
let g:ale_lint_on_text_changed = 'never'

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
map <F3> :!pdflatex % <ENTER>
map <SPACE> :w <ENTER>
map <F4> :silent !zathura %:r.pdf & <ENTER>
map <F2> :noh <ENTER>


function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
autocmd BufWritePre * %s/\s\+$//e
