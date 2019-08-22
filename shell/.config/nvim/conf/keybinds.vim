nnoremap <C-p> :Files<Cr>

cmap w!! %!sudo tee > /dev/null %
map <SPACE> :w <ENTER>
nmap <silent> <leader>h :History<CR>
nmap <silent> <leader>g :GitFiles<CR>
nmap <silent> <leader>o :FZF<CR>
nmap <silent> <leader>t :TagbarToggle<CR>

nnoremap <leader><space> :nohlsearch<CR>
nmap <silent> <C-j> :cn<CR>
nmap <silent> <C-k> :cp<CR>
map <C-n> :NERDTreeToggle<CR>

setlocal spell
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nmap <silent> <leader>af :ALEFix<CR>
