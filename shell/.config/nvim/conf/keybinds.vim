" FZF
nnoremap <C-p> :Files<Cr>
nmap <silent> <leader>f :History<CR>
nmap <silent> <leader>F :GitFiles<CR>

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

" Vim Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gm :Gcommit<CR>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>
