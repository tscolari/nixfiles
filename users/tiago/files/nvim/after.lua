vim.cmd [[

" Called after everything just before setting a default colorscheme
" Configure you own bindings or other preferences. e.g.:

" Disable swap files please {{{
set noswapfile
set nobackup
set nowb
" }}}

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss {{{
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s
" }}}

" Spelling extras {{{
setlocal spelllang=en_us
set spell spelllang=en_us

iab requrie require
iab emtpy empty
iab emtpy? empty?
iab intereset interest
iab proeprty property

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.rdoc setlocal spell
autocmd BufRead,BufNewFile *.markdown setlocal spell
autocmd FileType gitcommit setlocal spell
" }}}

" style {{{
colorscheme gruvbox
" }}}

" no folds {{{
set nofoldenable
set foldlevelstart=9999
" }}}

" Switch between test and production code {{{
nnoremap <leader>. :GoAlt<cr>
" }}}

" Set the -local flag to the current Go module
autocmd FileType go let b:go_fmt_options = {
      \ 'goimports': '-local ' .
      \ trim(system('{cd '. shellescape(expand('%:h')) .' && go list -m;}')),
      \ }

" Change the behaviour of the paste to not replace the copy when pasting in visual mode.
vnoremap p "_dP
]]
