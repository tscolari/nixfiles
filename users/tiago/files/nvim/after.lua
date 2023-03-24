vim.cmd [[

" Called after everything just before setting a default colorscheme
" Configure you own bindings or other preferences. e.g.:


" no folds {{{
set nofoldenable
set foldlevelstart=9999
" }}}


" Set the -local flag to the current Go module
autocmd FileType go let b:go_fmt_options = {
      \ 'goimports': '-local ' .
      \ trim(system('{cd '. shellescape(expand('%:h')) .' && go list -m;}')),
      \ }

]]
