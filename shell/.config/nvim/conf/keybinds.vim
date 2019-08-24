" FZF
nnoremap <C-p> :Files<Cr>
nmap <silent> <leader>h :History<CR>
nmap <silent> <leader>g :GitFiles<CR>

" Tagbar
nmap <silent> <leader>t :TagbarToggle<CR>

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>af :ALEFix<CR>

" Spelling
setlocal spell
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

