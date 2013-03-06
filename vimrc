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
Bundle 'scrooloose/syntastic'

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Syntastic
let g:syntastic_cpp_check_header = 1


