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
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'octol/vim-cpp-enhanced-highlight'

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
