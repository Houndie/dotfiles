" Include this file in your vimrc with
" source path/to/dotfiles/vimrc
" make sure vundle is installed in ~/.vim/bundle/vundle first!

"Vim improved only
set nocompatible
set formatoptions=tcr

" Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'vim-scripts/DoxygenToolkit.vim'

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Powerline
set laststatus=2
set encoding=utf-8
set t_Co=256
let g:Powerline_symbols='unicode'

" Other
filetype on
syntax on
set smartindent
set tabstop=3
set shiftwidth=3
set expandtab
map <C-u> :make!<CR>

" DoxygenToolkit.vim
let g:DoxygenToolkit_briefTag_pre = ""
