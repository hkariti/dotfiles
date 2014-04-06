filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/ListToggle'
Bundle 'Raimondi/delimitMate'
Bundle 'chase/vim-ansible-yaml'
Bundle 'edkolev/tmuxline.vim'
Bundle 'bling/vim-airline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'

filetype plugin on
filetype indent on

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set bg=dark

set t_Co=256
let g:tmuxline_powerline_separators = 0
set laststatus=2


let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
