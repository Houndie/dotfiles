" Include this file in your vimrc with
" source path/to/dotfiles/vimrc
" make sure vundle is installed in ~/.vim/bundle/vundle first!

"Vim improved only
set nocompatible
filetype off
set formatoptions=tcr

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Other
filetype plugin indent on
syntax on
set smartindent
set tabstop=3
set shiftwidth=3

"Ctrl-P
let g:ctrlp_extensions = ['tag']
let g:ctrlp_user_command =  ['.git', 'cd %s && git ls-files -co --exclude-standard']

"let g:ycm_always_populate_location_list = 1

let g:go_template_autocreate = 0
let g:go_fmt_command = "goimports"
let g:go_imports_mode = "goimports"
let g:go_fmt_options = { 'goimports': '-local fs/' }

autocmd FileType java setlocal shiftwidth=2 softtabstop=2 expandtab

au FileType qf wincmd J

let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_diagnostics_level = 2
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
