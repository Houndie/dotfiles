" Include this file in your vimrc with
" source path/to/dotfiles/vimrc
" make sure vundle is installed in ~/.vim/bundle/vundle first!

"Vim improved only
set nocompatible
set formatoptions=tcr

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'valloric/youcompleteme'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Powerline
set laststatus=2
set encoding=utf-8
set t_Co=256

" Other
filetype on
syntax on
set smartindent
set tabstop=3
set shiftwidth=3
map <C-u> :make!<CR>

" DoxygenToolkit.vim
let g:DoxygenToolkit_briefTag_pre = ""
let g:DoxygenToolkit_compactOneLineDoc = "yes"
"let g:DoxygenToolkit_commentType = "C++"
"let g:DoxygenToolkit_interCommentTag = " * "
let g:DoxygenToolkit_interCommentBlock = " * "

"Ctrl-P
let g:ctrlp_extensions = ['tag']

let g:ycm_always_populate_location_list = 1

color jellybeans
