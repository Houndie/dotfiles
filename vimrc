" Include this file in your vimrc with
" source path/to/dotfiles/vimrc
" make sure vundle is installed in ~/.vim/bundle/vundle first!

"Vim improved only
set nocompatible

" Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
" Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Syntastic
" let g:syntastic_cpp_check_header = 1

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
