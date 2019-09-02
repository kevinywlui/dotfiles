let g:ale_python_pyls_config = {
      \   'pyls': {
      \     'plugins': {
      \       'pylint': {
      \         'enabled': v:false
      \       }
      \     }
      \   },
      \ }

let g:ale_linters= {
\ 'sh' : ['shellcheck'],
\ 'python': ['pyls'],
\ 'tex': ['lacheck'],
\ 'vim': ['vint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'sh' : ['shfmt'],
\}

" lint on save and enter
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

let g:ale_completion_enabled = 0
