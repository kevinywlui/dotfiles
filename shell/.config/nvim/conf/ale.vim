"
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\}

" lint on save and enter
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
